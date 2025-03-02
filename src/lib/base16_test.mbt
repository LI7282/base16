test "base16" {
  let original = b"Hello, World";
  let originalBytes =  Bytes::to_array(original)
  // 编码
  let encoded = encodeToHex(originalBytes);
  println("Base16 Encoded: " + encoded);

  // 解码
  let decoded = decoderFromHex(encoded);
  println(decoded);

}
