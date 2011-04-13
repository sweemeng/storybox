import pygtk
pygtk.require('2.0')
import gtk
#import serial

class StoryBoard:
	def file_dialog(self, widget, file_name_entry):
		dialog = gtk.FileChooserDialog("Open..",
                	       None,
                       		gtk.FILE_CHOOSER_ACTION_OPEN,
                       		(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL,
                        	gtk.STOCK_OPEN, gtk.RESPONSE_OK))
		dialog.set_default_response(gtk.RESPONSE_OK)

		filter = gtk.FileFilter()
		filter.set_name("All files")
		filter.add_pattern("*")
		dialog.add_filter(filter)
		
		filter = gtk.FileFilter()
		filter.set_name("Text")
		filter.add_pattern("*.txt")
		dialog.add_filter(filter)
		
		response = dialog.run()
		if response == gtk.RESPONSE_OK:
			file_name_entry.set_text(dialog.get_filename())
		elif response == gtk.RESPONSE_CANCEL:
    			print 'Closed, no files selected'
		dialog.destroy()

	def enter_callback(self, widget, entry):
        	entry_text = entry.get_text()
        	print "Entry contents: %s\n" % entry_text

    	def entry_toggle_add(self, checkbutton, entry):
       		entry.set_editable(checkbutton.get_active())

    	def entry_toggle_visibility(self, checkbutton, entry):
        	entry.set_visibility(checkbutton.get_active())
	
	#def file_processing
	# add in one parameter for function
	def ok_button_callback(self, widget, file_name_entry, port_name_entry):
		file_name = file_name_entry.get_text()
		port_name = port_name_entry.get_text()
		file = open(file_name, 'r')
		packet = ""
		for line in file:
			print line.rstrip()
			packet += line.rstrip() + ':'
		file.closed
		print "packet: %s" % packet
		#comm = serial.Serial(port_name, 9600)
		#comm.write(packet)

		# serial connection at here


    	def __init__(self):
		file_name_entry = gtk.Entry(max=256)
        	# create a new window
        	window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        	#window.set_size_request(800, 600)
        	window.set_title("Story Board")
        	window.connect("delete_event", lambda w,e: gtk.main_quit())

        	vbox = gtk.VBox(False, 0)
        	window.add(vbox)
        	vbox.show()
		
		# Menu
		file_menu = gtk.Menu();
		open_menu_item = gtk.MenuItem("Open")
		file_menu.append(open_menu_item)
		open_menu_item.connect("activate", self.file_dialog, file_name_entry)
		open_menu_item.show()
		quit_menu_item = gtk.MenuItem("Quit")
		file_menu.append(quit_menu_item)
		quit_menu_item.connect("activate", lambda w,e: gtk.main_quit(), "Quit")
		quit_menu_item.show()
		file_root_menu = gtk.MenuItem("File")
		file_root_menu.show()
		file_root_menu.set_submenu(file_menu)

		menubar = gtk.MenuBar()
		vbox.pack_start(menubar, False, False, 0)
		menubar.show()
		menubar.append(file_root_menu)
	
		# Port name
		hbox = gtk.HBox(False, 0)
		vbox.pack_start(hbox)
		hbox.show()
		port_label = gtk.Label("Port name:")
		hbox.pack_start(port_label, False, False, 5)
		port_label.show()

        	port_name_entry = gtk.Entry()
        	port_name_entry.set_max_length(50)
        	port_name_entry.connect("activate", self.enter_callback, port_name_entry)
        	#port_name = port_name_entry.get_text()
        	hbox.pack_start(port_name_entry, False, False, 0)
	        port_name_entry.show()

		hbox_filename = gtk.HBox(False, 0)
		vbox.pack_start(hbox_filename)
		hbox_filename.show()
		file_name_label = gtk.Label("File name:")
		hbox_filename.pack_start(file_name_label, False, False, 0)
		file_name_label.show()

		hbox_filename.pack_start(file_name_entry, True, True, 0)
		file_name_entry.show()

        	hbox2 = gtk.HBox(False, 0)
        	vbox.add(hbox2)
        	hbox2.show()
        
		# Function
		function_label = gtk.Label("Function:")
        	hbox2.pack_start(function_label, False, False, 5)
        	function_label.show()

        	function_button = gtk.RadioButton(None, "Add")        
        	hbox2.pack_start(function_button, False, False, 0)
        	function_button.show()
    
        	function_button = gtk.RadioButton(function_button, "Delete")
        	hbox2.pack_start(function_button, False, False, 0)
        	function_button.show()
        
        	hbox3 = gtk.HBox(False, 0)
        	vbox.add(hbox3)
        	hbox3.show()
        
		# Buttons
        	ok_button = gtk.Button(stock=gtk.STOCK_OK)
		ok_button.connect("clicked", self.ok_button_callback, file_name_entry, port_name_entry)
        	hbox3.pack_start(ok_button, False, False, 0)
        	ok_button.show()
                                   
        	close_button = gtk.Button(stock=gtk.STOCK_CLOSE)
        	close_button.connect("clicked", lambda w: gtk.main_quit())
        	hbox3.pack_start(close_button, False, False, 0)
        	close_button.set_flags(gtk.CAN_DEFAULT)
        	close_button.grab_default()
        	close_button.show()
        	window.show()

def main():
    gtk.main()
    return 0

if __name__ == "__main__":
    StoryBoard()
    main()
