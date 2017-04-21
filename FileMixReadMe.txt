FILEMIX - Sugar Activity/Linux version - Notes
Art Hunkins
abhunkin@uncg.edu
www.arthunkins.com


Working with User Soundfiles/Objects

The four versions that comprise the FileMix utility series are:
FileMix4, FileMix4ASC, FileMix and FileMixASC. FileMix4 and
FileMix4ASC require 4 mono or stereo soundfiles, while FileMix and
FileMixASC can handle 1-4 of the same soundfiles. The files
can be of any sample rate and a variety of uncompressed formats
including WAV and AIFF; also Ogg/Vorbis, but not MP3. The Ogg/
Vorbis format is only possible when the Sugar version is later
than 0.84; this excludes the original XO-1 and SoaS
(Sugar-on-a-Stick) Strawberry.

*However*, the ogg vorbis format (which is written by later versions
of the Record activity) *can* be used by SoaS (Strawberry) 0.84 if
libsndfile is updated. This can be done while connected to the
internet by issuing the following commands in the Terminal:
  su <Enter>
  yum update libsndfile <Enter>
Neither the XO-1.5, nor XO-1 upgraded to Sugar 0.84 require this mod.

Students are encouraged to create their own soundfiles, especially
to make their own nature soundscapes. (This is the primary intent
behind these utilities. The four short "nature" files included here
are abbreviated versions of those from the author's DUSK AT ST.
FRANCIS SPRINGS [www.arthunkins.com].)

The natural vehicle for soundfile creation is the Record activity.
This activity is fairly simple and straightforward; the only problem
is that many versions of it do not work with various incarnations of
Sugar. The following pairings of Record with Sugar seem to work
reliably: v64 with Sugar-on-a-Stick Strawberry (0.84 - works rather
poorly); and v86 with XO-1.5, and XO-1 upgraded to Sugar 0.84. Sugar
0.86 (Blueberry) and above (as of 5/2011) are compatible with Record
v90/91, including XO's upgraded to at least Sugar 0.90 (Mango lassi -
Fedora 14). Please note that Record prior to v74 (except for v61-64)
produce ogg *speex* files; these files are incompatible with FileMix.

Soundfiles must be moved into the folder where this file resides,
and be renamed soundin.1 through soundin.4. Alternatively, and more
practically, however, user sound-files may be loaded from the Journal
(Sugar 0.84 and later). In this case, only wav and ogg/vorbis formats
are allowed.

Unfortunately, no other Sugar activity (including TimeLapse,
ShowNTell, and most importantly, Etoys) produces soundfiles useable
by FileMix. Either they write files other than Ogg Vorbis or wav, are
restricted to Sugar 0.82, or their output is inaccessible to the
Journal and other activities (the case with Etoys).

More advanced users may wish to record their soundfiles on some other
system, and import their wav or ogg vorbis files into the Journal via
a USB drive. (Display drive contents in Journal view, and drag your
file onto the Journal icon.)

Otherwise, adventurous users may run the fine Audacity application to
record and edit. (Happily, none of the limitations of the Record
activity apply here.) In the Terminal, connected to the web, enter:
  su <Enter>
  yum import audacity <Enter>
  ...
  audacity <Enter>
(you are now running Audacity from the Terminal).

When you are finished recording and editing (including auditioning the
file in loop mode), "Export" the file in wav or ogg vorbis format,
saving it to a USB drive with appropriate filename. Exit audacity. In
the Journal, display the contents of your USB drive, and drag your
newly-recorded file onto the Journal icon. It is now ready for FileMix.
 

MIDI Controller Hints (FileMix4 and FileMix versions only)

Important: The controller must be attached AFTER boot, and BEFORE
the version is selected. It is assumed that the controller is a USB
device. The inexpensive Korg nanoKontrol is one appropriate
controller choice; it can nicely handle either 8- or 9-slider
renditions (but not those requiring more than 9 sliders - *unless* you
want to reprogram the nanoKontrol). Choose Scene 4 on the Korg, and
Channel "0" in the performance window.

Be sure your controller has the number or knobs and/or sliders required
by your desired version. Also, check to see that your version
configuration settings agree with how your controller is set.

It is also important, with all versions, to wait 3 to 5 seconds
after pressing START, before moving any controls or pressing more
buttons/keys. FileMix *will not respond* to these actions until after
this time.

To facilitate performance of FileMix on the Korg nanoKontrol, its STOP
button has been programmed as a Delay Start option (buttons on the
device, by default, are *not* set to MIDI notes). It is conceivable
that this feature could interfere with MIDI controller selection
(Continuous Controller numbers). Solutions to this possible issue
are discussed in the FileMix.txt document on the author's website.
Other relevent items of interest may also be found in this document.  


No Sound - Sample Rate Issues

On a few systems, e.g. the Intel Classmate PC, the specified sr
(sample rate) of 44100 may not produce audio. Substitute a rate of
48000 (or, if necessary, 32000) toward the beginning of each .csd
file, using a text editor.


Audio Glitching/Breakup

If you get audio glitching, open Sugar's Control Panel, and turn off
Extreme power management (under Power) or Wireless radio (under
Network). Stereo headphones (an inexpensive set will work fine) or
external amplifier/speaker system are highly recommended.


Resizing the Font

The font display of this activity can be resized in csndsugui.py,
using any text editor. Further instructions are found toward the
beginning of csndsugui.py. (Simply change the value of the "resize"
variable (= 0), plus or minus.)

