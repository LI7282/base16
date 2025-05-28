// 十六进制字符数组
let global_hex_array:Array[Char] = "0123456789ABCDEF".to_array() 

// 编码方法
pub fn encodeToHex(bytes:Array[Byte]) -> String{
  let hexChars:Array[Char] = Array::make(bytes.length() * 2 , '0')
  for j = 0 ; j< bytes.length(); j = j + 1{
    let v = bytes[j] & 0xFF
    let highNibble = (v / 16) & 0x0F; 
    let lowNibble = v & 0x0F;
    hexChars[j * 2] = global_hex_array[highNibble.to_int()];
    hexChars[j * 2 + 1] = global_hex_array[lowNibble.to_int()];
  }
  return String::from_array(hexChars)
}

// 解码方法
pub fn decoderFromHex(hex:String) -> Array[Byte]{
  let len = hex.length()
  let data:Array[Byte] = Array::make(len/2, 0)
  for i = 0; i< len; i = i + 2{
    // 手动转换第一个十六进制字符为整数值
    let highNibble = convertHexCharToInt(Int::unsafe_to_char(hex.charcode_at(i)));
    // 手动转换第二个十六进制字符为整数值
    let lowNibble = convertHexCharToInt(Int::unsafe_to_char(hex.charcode_at(i+1)));
    data[i / 2] = ((highNibble << 4) + lowNibble).to_byte()
  }
  return data
}


fn convertHexCharToInt(c:Char) -> Int {
    let code = Char::to_int(c);
    if (c >= '0' && c <= '9') {
        // 字符 '0' - '9' 对应的整数值为 0 - 9
        return code - Char::to_int('0');
    } else if (c >= 'A' && c <= 'F') {
        // 字符 'A' - 'F' 对应的整数值为 10 - 15
        return code - Char::to_int('A') + 10;
    } else if (c >= 'a' && c <= 'f') {
        // 字符 'a' - 'f' 对应的整数值为 10 - 15
        return code - Char::to_int('a') + 10;
    } else {
        return -1;
    }
}
