# FILEMIX - Audio File Player/Mixer/Processor Utilities for Children (2010)
# Art Hunkins (www.arthunkins.com)
#   
#    FileMix is licensed under the Creative Commons Attribution-Share
#    Alike 3.0 Unported License. To view a copy of this license, visit
#    http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to
#    Creative Commons, 171 Second Street, Suite 300, San Francisco,
#    California, 94105, USA.
#
#    It is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# version 10  Changes:
#    GUI tweaks


import csndsugui
from sugar.activity import activity
from sugar.graphics.objectchooser import ObjectChooser
from sugar import mime
import gtk
import os

class FileMix(activity.Activity):

 def __init__(self, handle):
  
   activity.Activity.__init__(self, handle)

   red = (0xDDDD, 0, 0)
   brown = (0x6600, 0, 0)
   green = (0, 0x5500, 0)
   self.paths = ["0"]*5
   self.jobjects = [None]*5
   self.buts = [None]*5

   win = csndsugui.CsoundGUI(self)
   width = gtk.gdk.screen_width()
   height = gtk.gdk.screen_height()
   if os.path.exists("/etc/olpc-release") or os.path.exists("/sys/power/olpc-pm"):
     adjust = 78
   else:
     adjust = 57
   screen = win.box()
   screen.set_size_request(width, height - adjust)
   scrolled = gtk.ScrolledWindow()
   scrolled.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
   screen.pack_start(scrolled)
   all = gtk.VBox()
   all.show()
   scrolled.add_with_viewport(all)
   scrolled.show()

   win.text("<big><b><big><u>FILEMIX</u> - Audio File Player/Mixer/Processor \
Utilities for Children (2010)</big></b>\n\
\t\t\t\t    Art Hunkins (www.arthunkins.com)</big>", all)

   win.text("\
<b>FileMix4</b> and <b>FileMix4ASC</b> play 4 mono/stereo files; wav and \
ogg vorbis formats only (no ogg vorbis on Sugar 0.84).\n\
<b>FileMix</b> and <b>FileMixASC</b> play 1-4 mono and/or stereo files; \
formats as above. These versions include more options.\n\
  User sound files must be placed in Journal (Record activity \
does this). <b>No user files on Sugar 0.82</b> (original XO-1).\n\
  The default files are abbreviated versions of those from the author's \
<b>DUSK AT ST. FRANCIS SPRINGS</b>.\n\
  You are urged to create your own sound files, for example, with the Record \
activity - especially nature soundscapes.", all, brown)
   win.text("<b>FileMix4</b> and <b>FileMix</b> require MIDI controllers; \
the # of knobs/sliders depends on the # of files/parameters you control. \n\
  All knobs/sliders are adjoining, and like parameters are grouped: \
volume, then peak freq, peak gain, lastly speed/freq.\n\
  A Master volume control (all files are affected) is optional, and may \
be separated from the other controls.", all, green)
   win.text("<b>FileMix4ASC</b> and <b>FileMIXASC</b> don't use MIDI; \
control is via 1 or more ASCII keyboards.\n\
  <b>ASCII keys</b> used: (glide time in seconds) 1-0(10); ` (to left of 1) \
= 0(.1) seconds (takes effect with next keypress) -       \n\
    (volume) A,S,D,F - (band-pass freq peak) Q,W,E,R - (peak gain) J,K,L,; - \
(speed/freq) U,I,O,P\n\
    Unshifted=up by .5 (1 max); shifted=down by .5 (0 min); \
<b>top alphabetic rows go <i>negative as well as positive</i></b>.\n\
    G,H = all files off; V,B,N = all files off and reset to \
defaults. Note: SPACE bar and ENTER only START and STOP.", all, brown)
   win.text("<b>FileMix(ASC)</b> offers delayed start - for single play, sync/\
'play from head' options. Hit ASCII key/MIDI note to begin play. ", all, 
green)

   win.text("\
\t<b>1 - FileMix4</b>  Simple; MIDI controller with 4-16(17) knobs/sliders \
(#17 = optional Master volume)\n\
\t<b>2 - FileMix4ASC</b>  Simple; 1 or more ASCII keyboards\n\
\t<b>3 - FileMix</b>  \
Advanced; MIDI controller with 1-16(17) knobs/sliders (#17 = optional \
Master volume)\n\
\t<b>4 - FileMixASC</b>  Advanced; 1 or more ASCII keyboards\n\
<i><b>MIDI</b>: plug in controller after boot &amp; before selecting. \
Zero controls before start; reset peak freq &amp; speed/freqs \
to .5 after.\n<b>ALL VERSIONS</b>: IMPORTANT! \
Key presses &amp; controller motion prior to 3-5 seconds after hitting START \
are ignored.</i> ", all, brown)
   nbox = win.box(False, all)
   self.b2box = win.box(False, all)
   but1 = win.cbbutton(nbox, self.version1, "   1 FileMix4    ")
   but1.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   but1.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   but2 = win.cbbutton(nbox, self.version2, "2 FileMix4ASC")
   but2.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   but2.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   but3 = win.cbbutton(nbox, self.version3, "    3 FileMix    ")
   but3.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   but3.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   but4 = win.cbbutton(nbox, self.version4, " 4 FileMixASC ")
   but4.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   but4.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))
   win.text("<b> MIDI DEVICE REQUIRED</b> for 1 and 3", nbox, green)

   try:
     from jarabe import config
     version = [int(i) for i in config.version.split('.')][:2]
   except ImportError:
     version = [0, 82]
   if version >= [0, 84]:
     win.text("  Optionally, <b>before choosing version</b>, \
select your own <b>audio</b> file(s) from Journal.\n\
  Deselect by closing Journal. Create files with Record \
or Audacity (see ReadMe.txt).", self.b2box, brown)
     win.text("   Load File(s):", self.b2box, brown)
     for i in range(1,5):
       self.buts[i] = win.cbbutton(self.b2box, self.choose, " %d " %i)
       self.buts[i].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0x6600, 0, 0))

   bbox = win.box(False, all)
   self.bb = bbox
   self.w = win
   self.r = red
   self.g = green
   self.br = brown
   self.ver = 0

 def choose(self, widget):
   chooser = ObjectChooser(parent=self, what_filter=mime.GENERIC_TYPE_AUDIO)
   result = chooser.run()
   index = self.b2box.child_get_property(widget, "position")
   index = index - 1
   if result == gtk.RESPONSE_ACCEPT:
     self.jobjects[index] = chooser.get_selected_object()
     self.paths[index] = str(self.jobjects[index].get_file_path())
     self.buts[index].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x8800, 0))
     self.buts[index].modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x8800, 0))
   else:
     self.paths[index] = "0"
     self.jobjects[index] = None
     self.buts[index].modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0x6600, 0, 0))
     self.buts[index].modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0x6600, 0, 0))

 def send_data(self):
   for i in range(1, 5):
     self.w.set_filechannel("file%d" % i, self.paths[i])

 def onKeyPress(self, widget, event):
   if self.p:
     if self.ver > 1:
       self.w.set_channel("ascii", event.keyval)

 def playcsd(self, widget):
   if self.p == False:
     self.p = True
     self.w.play()
     self.but.child.set_label("STOP !")
     self.but.child.set_use_markup(True)
     self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0xFFFF, 0, 0))
     self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0xFFFF, 0, 0))
     if self.ver > 1:
       self.connect("key-press-event", self.onKeyPress)
   else:
     self.p = False
     self.w.recompile()
     self.w.channels_reinit()
     self.send_data()
     self.but.child.set_label("START !")
     self.but.child.set_use_markup(True)
     self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
     self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))

 def version1(self, widget):
   if self.ver != 0:
     self.box1.destroy()
     self.box2.destroy()
   else:
     self.b2box.destroy()
   self.ver = 1
   self.box1 = self.w.box(True, self.bb)
   self.w.text("", self.box1)
   self.box2 = self.w.box(True, self.bb)
   self.f = self.w.framebox(" <b>1 - FileMix4</b> ", False, self.box2, self.r)
   self.b1 = self.w.box(True, self.f)
   self.b2 = self.w.box(True, self.f)
   self.b3 = self.w.box(True, self.f)
   self.b4 = self.w.box(True, self.f)
   self.w.reset()
   self.w.csd("FileMix4.csd")
   self.w.spin(0, 0, 16, 1, 1, self.b1, 0, "chan", "Channel #  [0=CC7,\n    \
channels 1-16]")
   self.w.spin(20, 0, 120, 1, 1, self.b1, 0, "ctrl1", "1st Control Bank1")
   self.w.spin(28, 0, 120, 1, 1, self.b2, 0, "ctrl2", "1st Control Bank2")
   self.w.spin(9, -1, 127, 1, 1, self.b2, 0, "mast", "Master Controller\n\
  [-1=no Master]") 
   self.w.spin(4, 1, 4, 1, 1, self.b3, 0, "parms", " # of Parameters\n\
 [1=amp 2=band-\n  pass peak freq\n   3=peak gain\n  4=speed/freq]")
   self.p = False
   self.w.text("\n<i>Select options first </i>", self.b4, self.g)
   self.send_data() 
   self.but = self.w.cbbutton(self.b4, self.playcsd, "START !")
   self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))

 def version2(self, widget):
   if self.ver != 0:
     self.box1.destroy()
     self.box2.destroy()
   else:
     self.b2box.destroy()
   self.ver = 2
   self.box1 = self.w.box(True, self.bb)
   self.w.text("\t\t\t   ", self.box1)
   self.box2 = self.w.box(True, self.bb)
   self.f = self.w.framebox(" <b>2 - FileMix4ASC</b> ", False, self.box2, self.r)
   self.b1 = self.w.box(True, self.f)
   self.b2 = self.w.box(True, self.f)
   self.w.reset()
   self.w.csd("FileMix4ASC.csd")
   self.w.spin(4, 1, 4, 1, 1, self.b1, 0, "parms", " # of Parameters\n\
 [1=amp 2=band-\n  pass peak freq\n   3=peak gain\n  4=speed/freq]")
   self.p = False
   self.w.text("\n<i>Select option first </i>", self.b2, self.g)
   self.send_data() 
   self.but = self.w.cbbutton(self.b2, self.playcsd, "START !")
   self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))

 def version3(self, widget):
   if self.ver != 0:
     self.box1.destroy()
     self.box2.destroy()
   else:
     self.b2box.destroy()
   self.ver = 3
   self.box1 = self.w.box(True, self.bb)
   self.w.text(" ", self.box1)
   self.box2 = self.w.box(True, self.bb)
   self.f = self.w.framebox(" <b>3 - FileMix</b> ", False, self.box2, self.r)
   self.b1 = self.w.box(True, self.f)
   self.b2 = self.w.box(True, self.f)
   self.b3 = self.w.box(True, self.f)
   self.b4 = self.w.box(True, self.f)
   self.b5 = self.w.box(True, self.f)
   self.b6 = self.w.box(True, self.f)
   self.w.reset()
   self.w.csd("FileMix.csd")
   self.w.spin(0, 0, 16, 1, 1, self.b1, 0, "chan", "Channel #  [0=CC7,\n    \
channels 1-16]")
   self.w.spin(20, 0, 120, 1, 1, self.b1, 0, "ctrl1", "1st Control Bank1")
   self.w.spin(28, 0, 120, 1, 1, self.b2, 0, "ctrl2", "1st Control Bank2")
   self.w.spin(9, -1, 127, 1, 1, self.b2, 0, "mast", "Master Controller\n\
  [-1=no Master]") 
   self.w.spin(4, 1, 4, 1, 1, self.b3, 0, "parms", " # of Parameters\n\
 [1=amp 2=band-\n  pass peak freq\n   3=peak gain\n  4=speed/freq]")
   self.w.spin(4, 1, 4, 1, 1, self.b4, 0, "files", "# of Files")
   self.w.button(self.b4, "random", "Start at Head?")
   self.w.button(self.b4, "loop", "Single Play ?")
   self.w.button(self.b5, "delay", "Delay Start ?")
   self.w.text("If delay, hit any key/\nMIDI note to begin.\n\
 [Volumes up first,\n &amp; set fadein/out.]", self.b5, self.g)
   self.w.spin(-2, -3, 30, 1, 1, self.b6, 0, "fade", " FadeIn/Out Seconds\n\
[-3=.01/-2=.1/-1=.5]")
   self.p = False
   self.w.text("<i>Select options first </i>", self.b6, self.g)
   self.send_data() 
   self.but = self.w.cbbutton(self.b6, self.playcsd, "START !")
   self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))

 def version4(self, widget):
   if self.ver != 0:
     self.box1.destroy()
     self.box2.destroy()
   else:
     self.b2box.destroy()
   self.ver = 4
   self.box1 = self.w.box(True, self.bb)
   self.w.text("\t\t\t\t\t\t\t\t     ", self.box1)
   self.box2 = self.w.box(True, self.bb)
   self.f = self.w.framebox(" <b>4 - FileMixASC</b> ", False, self.box2, \
self.r)
   self.b1 = self.w.box(True, self.f)
   self.b2 = self.w.box(True, self.f)
   self.b3 = self.w.box(True, self.f)
   self.b4 = self.w.box(True, self.f)
   self.w.reset()
   self.w.csd("FileMixASC.csd")
   self.w.spin(4, 1, 4, 1, 1, self.b1, 0, "parms", " # of Parameters\n\
 [1=amp 2=band-\n  pass peak freq\n   3=peak gain\n  4=speed/freq]")
   self.w.spin(4, 1, 4, 1, 1, self.b2, 0, "files", "# of Files")
   self.w.button(self.b2, "random", "Start at Head?")
   self.w.button(self.b2, "loop", "Single Play ?")
   self.w.button(self.b3, "delay", "Delay Start ?")
   self.w.text(" If delay, press T\n   or Y to begin.\n\
[Volumes up first,\n&amp; set fadein/out.]", self.b3, self.g)
   self.w.spin(-2, -3, 30, 1, 1, self.b4, 0, "fade", " FadeIn/Out Seconds\n\
[-3=.01/-2=.1/-1=.5]")
   self.p = False
   self.w.text("<i>Select options first </i>", self.b4, self.g)
   self.send_data() 
   self.but = self.w.cbbutton(self.b4, self.playcsd, "START !")
   self.but.modify_bg(gtk.STATE_NORMAL, gtk.gdk.Color(0, 0x7700, 0))
   self.but.modify_bg(gtk.STATE_PRELIGHT, gtk.gdk.Color(0, 0x7700, 0))



