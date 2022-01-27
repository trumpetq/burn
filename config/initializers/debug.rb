def d(*args)
  puts "#" * 80
  nice = args.map do |a|
    next "\033[1mNIL\033[0m" if a.nil?
    next "\033[1mFALSE\033[0m" if a.is_a?(FalseClass)
    next "\033[1mTRUE\033[0m" if a.is_a?(TrueClass)
    next "\033[1mEMPTY STRING\033[0m" if a == ""
    next "\033[1mEMPTY HASH\033[0m" if a.blank? && a.is_a?(Hash)
    next "\033[1mEMPTY ARRAY\033[0m" if a.blank? && a.is_a?(Array)
    next "\033[1mBLANK\033[0m" if a.blank?
    next a.to_s if a.is_a?(Enumerable)

    a
  end
  puts nice.join(" ")
  puts "#" * 80
end
