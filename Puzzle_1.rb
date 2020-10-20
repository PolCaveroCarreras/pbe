require ‘ruby-nfc’
class Rfid
# return uid in hexa str

	#constructor de la classe del modul NFC
	def initialize
		readers = NFC::Reader.all
	end
 
  	def read_uid 

		  #obtenim el tag llegint la NFC
		  readers[0].poll(IsoDep::Tag, Mifare::Classic::Tag, Mifare::Ultralight::Tag) do |tag|

			  #volem el id en hexadecimal
			  uid = uid_hex
			  return uid

		  end
  	end 
end
 
if _FILE_ == $0 
  puts “Sisplau escaneja la teva targeta:”
  rf = Rfid.new 
  uid = rf.read_uid 
  puts uid 
end
