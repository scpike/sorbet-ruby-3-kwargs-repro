# typed: true

class Foo
  def bar(x:, y:)
    [x, y]
  end

  def baz
    bar({ x: 1, y: 2 })
    bar(x: 1)
  end
end

