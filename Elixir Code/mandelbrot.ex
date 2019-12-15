defmodule Cmplxoldp do

  def new(r, i) do
    {r, i}
  end

  def add(a, b) do
    {x, y} = a
    {v, w} = b
    {x + v, y + w}
  end

  def sqr(a) do
    {x, y} = a
    {x*x - y*y, 2*x*y}
  end

  def abs(a) do
    {x, y} = a
    :math.sqrt(x*x + y*y)
  end

end

defmodule Brot do

  def mandelbrot(c, m) do
    z0 = Cmplx.new(0, 0)
    i = 0
    test(i, z0, c, m)
  end

  def test(i, _z, _c, m) when i == m do 0 end
  def test(i, z, c, m) do
    case Cmplx.abs(z) > 2 do
      true ->
        i
      false ->
        zn = Cmplx.add(Cmplx.sqr(z), c)
        test(i + 1, zn, c, m)
    end
  end

end

defmodule Color do

  def convert(depth, max) do
    f = depth/max
    a = 4*f
    x = trunc(a)
    y = trunc(255 * (a - x))
    case x do
      #0 -> {:rgb, y, 0, 0}
      #1 -> {:rgb, 255, y, 0}
      #2 -> {:rgb, 255 - y, 255, 0}
      #3 -> {:rgb, 0, 255, y}
      #4 -> {:rgb, 0, 255 - y, 255}
      0 -> {:rgb, 0, 0, y}
      1 -> {:rgb, 0, y, 255}
      2 -> {:rgb, 0, 255, 255 - y}
      3 -> {:rgb, y, 255, 0}
      4 -> {:rgb, 255, 255 - y, 0}
    end
  end
end

defmodule Mandel do

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
    Cmplx.new(x + k * (w - 1), y - k * (h - 1)) end

    rows(width, height, trans, depth, [])
  end

  def rows(_, 0, _, _, rows) do rows end
  def rows(width, height, trans, depth, rows) do
    row = row(width, height, trans, depth, [])
    rows(width, height - 1, trans, depth, [row | rows])
  end

  def row(0, _, _, _, row) do row end
  def row(width, height, trans, depth, row) do
    c = trans.(width, height)
    result = Brot.mandelbrot(c, depth)
    color = Color.convert(result, depth)
    row(width - 1, height, trans, depth, [color | row])
  end


  def demo() do
    small(-0.16, 0.9, -0.14)
  end

  def small(x0, y0, xn) do
    width = 1920
    height = 1080
    depth = 50
    k = (xn - x0) / width
    image = mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("zoom.ppm", image)
  end

end
