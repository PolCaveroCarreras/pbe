require 'ruby-nfc'
require 'gtk3'

class Rfid
	def initialize
		@readers = NFC::Reader.all
	end
	def read_uid
		@readers[0].poll(IsoDep::Tag, Mifare::Classic::Tag, Mifare::Ultralight::Tag) do |tag|
			uid = uid_hex.upcase
			return uid
		end
	end
end

class Puzle2 < Gtk::Window
def initialize
		super
		set_title "Puzle 2"
		signal_connect "destroy" do Gtk.main_quit end
		set_default_size 640,300
		set_window_position Gtk::WindowPosition::CENTER
		@grid = Gtk::Grid.new
		add(@grid)
		button = Gtk::Button.new ::label => “Clear”
		button.signal_connect "clicked" do |object|
			@css_provider.load data: "label {background-color: blue;} \ label {color: white;} \ label {border-radius: Opx;}"
			@label.style_context.add_provider(@css_provider, Gtk::StyleProvider::PRIORITY_USER)
			@label.set_label "Please, log in with your university card"
		end
		button.set_size_request 640,50
		@grid.attach button,0,1,1,1
		@label = Gtk::label.new
		@label.set_label "Please, log in with your university card"
		@css_provider = Gtk::CssProvider.new
		@css_provider.load data: "label {background-color: blue;} \ label{color: white;} \ label {border-radius: Opx;}"
		@label.style_context.add_provider @css_provider,Gtk::StyleProvider::PRIORITY_USER
		@label.set_size_request 640,250
		@grid.attach @label,0,0,2,1
		show_all

		def set_text(string)
			@css_provider.load data: "label {background-color: red;} \ label{color: white;} \ label {border-radius: Opx;}"
			@label.style_context.add_provider (css_provider,Gtk::StyleProvider::PRIORITY_USER)
			@label.set_label "UID: #{string}"
		return false
		end
	
		def auxiliar(string)
		Glib::Idle.add{set_text(string)}
		end
end


if __FILE__ == $0
	window = Puzzle2.new
	rf = Rfid.new
	t = Thread.new{ while(1) do
		window.auxiliar(rf.read_uid())
		sleep 2
	end}
	Gtk.main
end
