Here's what prints in the lsp log:

```
[T10307957][2022-09-23T18:17:35.753015] Running fast path over num_files=1
[T10307957][2022-09-23T18:17:35.753905] [ErrorReporter] Sending diagnostics for file file:///Users/steve/dev/sorbet-ruby-3-kwargs-repro/kwargs.rb, epoch 1
[T10307957][2022-09-23T18:17:35.753936] Write: {"jsonrpc":"2.0","method":"textDocument/publishDiagnostics","params":{"uri":"file:///Users/steve/dev/sorbet-ruby-3-kwargs-repro/kwargs.rb","diagnostics":[{"range":{"start":{"line":9,"character":8},"end":{"line":9,"character":12}},"severity":1,"code":7004,"codeDescription":{"href":"https://srb.help/7004"},"message":"Missing required keyword argument `y` for method `Foo#bar`","relatedInformation":[{"location":{"uri":"file:///Users/steve/dev/sorbet-ruby-3-kwargs-repro/kwargs.rb","range":{"start":{"line":3,"character":14},"end":{"line":3,"character":16}}},"message":"Keyword argument `y` declared to expect type `T.untyped` here:"}]}]}}
```

But running manually shows both errors:

```
steve@Stephens-Air sorbet-ruby-3-kwargs-repro % bundle exec srb tc   
[T10308893][2022-09-23T18:18:49.571799] Debug logging enabled
[T10308893][2022-09-23T18:18:49.572206] Running sorbet version 0.5.10455 git 3542f977568c181cf0f908bd0f89bc3a6282a53b debug_symbols=true clean=1 with arguments: /Users/steve/.rbenv/versions/3.1.0/lib/ruby/gems/3.1.0/gems/sorbet-static-0.5.10455-universal-darwin-21/libexec/sorbet @/Users/steve/.cache/sorbet/gem-rbis/3d11a93f5f2574bf021cc3777dab5fd7
[T10308893][2022-09-23T18:18:49.589776] kwargs.rb:9: Keyword argument hash without ** is deprecated https://srb.help/7033
     9 |    bar({ x: 1, y: 2 })
                ^^^^^^^^^^^^^^
    kwargs.rb:9: This produces a runtime warning in Ruby 2.7, and will be an error in Ruby 3.0
     9 |    bar({ x: 1, y: 2 })
                ^^^^^^^^^^^^^^
  Autocorrect: Use `-a` to autocorrect
    kwargs.rb:9: Replace with **{ x: 1, y: 2 }
     9 |    bar({ x: 1, y: 2 })
                ^^^^^^^^^^^^^^

kwargs.rb:10: Missing required keyword argument y for method Foo#bar https://srb.help/7004
    10 |    bar(x: 1)
                ^^^^
    kwargs.rb:4: Keyword argument y declared to expect type T.untyped here:
     4 |  def bar(x:, y:)
                      ^^
```