defmodule Huffman do

  def sample do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def text, do: 'this is something that we should encode'

  def test do
    sample = sample()
    tree = tree(sample)
    encode = encode_table(tree)
    decode = decode_table(tree)
    text = text()
    seq = encode(text, encode)
    decode(seq, decode)
  end

  def tree(sample) do # To implement...
    freq = freq(sample)
    huffman(freq)
  end

  def freq(sample) do freq(sample, %{}) end
  def freq([], freq) do freq end
  def freq([char | rest], freq) do
    case Map.has_key?(freq, char) do
      false ->
        freq(rest, Map.put(freq, char, 1))
      true ->
        freq(rest, Map.replace(freq, char, freq[char] + 1))
    end
  end




  #def freq(sample) do freq(sample, %{}) end
  #def freq([], freq) do freq end
  #def freq([char | rest], freq) do
  #  map = freq
  #  value = map[char]
  #  case value do
  #    nil -> updateval = 1
  #    _ -> updateval = value + 1
  #  end
  #  updatefreq = Map.put(map, char, updateval)
  #  freq(rest, updatefreq)
  #
  #end
  #find the first element, add it to the tuple with value 1
  #go to the next element, if it exists in the list, increment its value by one. if not, create a new tuple with the value 1






  def huffman(freq) do
    List.keysort(freq, 0) 
  end


  def encode_table(tree) do # To implement...

  end

  def decode_table(tree) do # To implement...

  end

  def encode(text, table) do # To implement...

  end

  def decode(seq, tree) do # To implement...

  end



end
