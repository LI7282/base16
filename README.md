# 190521229/base16

# Base16 编码和解码工具
简介
本工具提供了 moonbit 实现的 Base16（十六进制）编码和解码功能。Base16 编码是一种将二进制数据转换为十六进制字符串的方法，常用于数据传输和存储，方便人类查看和处理二进制数据。通过本工具，你可以轻松地将字节数组编码为十六进制字符串，也可以将十六进制字符串解码为字节数组。

global_hex_array 是一个字符数组，存储了十六进制字符 0 - 9 和 A - F，用于将二进制数据转换为十六进制字符。

# 编码方法
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

功能：将字节数组编码为十六进制字符串。
参数： bytes：待编码的字节数组。

1. 创建一个长度为 bytes.length * 2 的字符数组 hexChars，因为每个字节需要用两个十六进制字符表示。
2. 遍历字节数组，对于每个字节：
    let v = bytes[j] & 0xFF ：将字节转换为无符号整数，确保负数也能正确处理。
    let highNibble = (v / 16) & 0x0F; ：使用除法替代右移操作，提取字节的高 4 位。
    let lowNibble = v & 0x0F;：提取字节的低 4 位。
    将高 4 位和低 4 位分别转换为对应的十六进制字符，并存储在 hexChars 数组中。
3. 将 hexChars 数组转换为字符串并返回。

# 解码方法
pub fn decoderFromHex(hex:String) -> Array[Byte]{
  let len = hex.length()
  let data:Array[Byte] = Array::make(len/2, 0)
  for i = 0; i< len; i = i + 2{
    // 手动转换第一个十六进制字符为整数值
    let highNibble = convertHexCharToInt(Char::from_int(hex.charcode_at(i)));
    // 手动转换第二个十六进制字符为整数值
    let lowNibble = convertHexCharToInt(Char::from_int(hex.charcode_at(i+1)));
    data[i / 2] = ((highNibble << 4) + lowNibble).to_byte()
  }
  return data
}

功能：将十六进制字符串解码为字节数组。
参数： hex：待解码的十六进制字符串。
实现步骤：
1. 创建一个长度为 hex.length() / 2 的字节数组 data，因为每两个十六进制字符对应一个字节。
2. 遍历十六进制字符串，每次处理两个字符。
3. 返回解码后的字节数组。


### 注意事项
本工具假设输入的十六进制字符串长度为偶数，因为每两个十六进制字符对应一个字节。如果输入的字符串长度为奇数，解码结果可能不符合预期。