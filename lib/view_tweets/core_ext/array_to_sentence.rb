module ArrayToSentence
  def to_sentence
    case size
    when 0
      ""
    when 1
      first
    when 2
      "#{first} and #{last}"
    else
      "#{self[0..-2].join(", ")} and #{last}"
    end
  end
end

Array.__send__ :include, ArrayToSentence
