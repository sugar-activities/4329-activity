; FileMix (2010) for realtime Csound5 - by Arthur B. Hunkins
;  requires MIDI device with 1-16(17) knobs/sliders; 1-4 files
;  1-4 controls per file (amp, band-pass peak freq, peak gain, speed/freq)
;  Quantity of knobs/sliders needed = number of files * number of parameters.
;   An additional controller is optional Master volume.
;  Files may be mono or stereo; can have different sample rates, may be a variety of
;   uncompressed types including WAV and AIFF; also Ogg/Vorbis (with Sugar 0.86/
;   Blueberry or later, or Sugar 0.84/Strawberry with updated libsndfile) but not MP3.
;  They must be named soundin.1 (through soundin.4), and in the same folder as this file,
;   or they may be loaded through the Journal (with Sugar 0.84/Strawberry or later).

<CsoundSynthesizer>
<CsOptions>

-odac -+rtaudio=alsa -+rtmidi=alsa -M hw:1,0 -m0d --expression-opt -b128 -B2048 -+raw_controller_mode=1

</CsOptions>
<CsInstruments>

sr      = 44100
; change sample rate to 48000 (or 32000 if necessary) when 44100 gives no audio.
; (Necessary for Intel Classmate PC and some other systems.)
ksmps   = 100
nchnls  = 2

gichan  chnexport "chan", 1
gictrl1 chnexport "ctrl1", 1
gictrl2 chnexport "ctrl2", 1
gimast  chnexport "mast", 1
gifile  chnexport "files", 1
gistrt  chnexport "random", 1
gidel   chnexport "delay", 1
gifade  chnexport "fade", 1
giloop  chnexport "loop", 1
giparm  chnexport "parms", 1
gkasc	chnexport "ascii", 1

        massign 0, 0
        seed    0
ga1     init    0
ga2     init    0
gktrig  init    0
gkasc	init	0
        
gitemp  ftgen   2, 0, 512, -5, 200, 512, sr / 13.2

        instr 1, 2, 3, 4

        if p1 > 1 igoto skip
gimast  =       ((gichan == 0) && (gifile == 4) && (giparm == 4)? -1: gimast)
        if gifile == 1 igoto skip
        event_i "i", 2, 0, 3600
        if gifile == 2 igoto skip
        event_i "i", 3, 0, 3600
        if gifile == 3 igoto skip
        event_i "i", 4, 0, 3600
skip:

        if p1 != 1 goto cont
Sname   chnget  "file1"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.1"
        goto cont2
cont:
        if p1 != 2 goto cont3
Sname   chnget  "file2"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.2"
        goto cont2
cont3:
        if p1 != 3 goto cont4
Sname   chnget  "file3"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.3"
        goto cont2
cont4:                
Sname   chnget  "file4"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.4"
cont2:                
        if (gidel == 0) || (gktrig == 1) goto skip2
kstat,kchan,kdata1,kdata2 midiin
; line below allows default STOP key on the Korg nanoKontrol to terminate delay
        if (kstat == 176) && (kdata1 == 44) && (kdata2 == 127) goto skip3
        if (kstat != 144) && (gkasc == 0) goto skip2
skip3:
gktrig  =       1        
skip2:           
kamp	ctrl7   (gichan == 0? p1: gichan), (gichan == 0? 7: gictrl1 + (p1 - 1)), 0, 1
kamp2   table   kamp * 512, 1
kamp2   port    kamp2, .01
ichans  filenchnls Sname
ilen    filelen Sname
ipeak   filepeak Sname
imult   =       32760 / gifile / ipeak
kamp2   =       kamp2 * imult
irand   unirand ilen * .75
istart  =       (gistrt == 0? irand: 0)
; physically set these controllers (speed/freq) to .5 after start
iplace4 =       p1 + (gifile * 3) - 1
ictrl4  =       (iplace4 > 7? gictrl2 + iplace4 - 8: gictrl1 + iplace4)     
kbase   ctrl7   (gichan == 0? iplace4 + 1: gichan), (gichan == 0? 7: ictrl4), .9, 1.1
kbase   port    kbase, .01
kbase   =       (giparm == 4? kbase: 1)
        if (gidel == 1) && (gktrig == 0) goto end
iloop	=	(giloop == 1? 0: 1)
        if ichans == 2 goto skip4
a1      diskin2 Sname, kbase, istart, iloop
        if giparm > 1 goto skip5
        goto skip6  
skip4:        
a1, a2  diskin2 Sname, kbase, istart, iloop
        if giparm > 1 goto skip5
        goto skip6  
skip5:
; physically set these controllers (band-pass peak freq) to .5 after start
ictrl2  =       p1 + gifile - 1     
kfreq   ctrl7   (gichan == 0? ictrl2 + 1: gichan), (gichan == 0? 7: gictrl1 + ictrl2), 0, 512
kfreq   table   kfreq, 2
kfreq   port    kfreq, .01
iplace3 =       p1 + (gifile * 2) - 1
ictrl3  =       (iplace3 > 7? gictrl2 + iplace3 - 8: gictrl1 + iplace3)     
kres    ctrl7   (gichan == 0? iplace3 + 1: gichan), (gichan == 0? 7: ictrl3), .25, .7
kres    port    kres, .01
kres    =       (giparm > 2? kres: .25)
a3,a4,a5 svfilter a1, kfreq, kres, 1
        if ichans == 1 goto skip7
a6,a7,a8 svfilter a2, kfreq, kres, 1
skip7:
        if giparm == 2 goto skip6
kamp2   =       kamp2 + (kamp2 * 3 * (kres - .25))
skip6:
ifade   =       gifade
	if gifade > 0 goto skip8
ifade	tab_i	gifade + 3, 3
skip8:
kamp3   linseg  0, ifade, 1, (iloop == 0? ilen - (ifade * 2) - istart: .01), 1, (iloop == 0? ifade: .01), (iloop == 0? 0: 1)   
kamp2   =       kamp2 * kamp3
ga1     =       ga1 + ((giparm == 1? a1: a5) * kamp2)   
ga2     =       ga2 + ((giparm == 1? (ichans == 1? a1: a2): (ichans == 1? a5: a8)) * kamp2)  
end:
        endin
   
        instr 5

        if gifile == 1 goto skip
        if (gichan > 0) && (gimast > -1) goto skip2
        if ((gifile < 4) || (giparm < 4)) && (gichan == 0) && (gimast > -1) goto skip2
skip:
kamp2   =       1
        goto skip3 
skip2:
kamp	ctrl7   (gichan == 0? gimast: gichan), (gichan == 0? 7: gimast), 0, 1
kamp2   table   kamp * 512, 1
kamp2   port    kamp2, .01
skip3:
        outs    ga1 * kamp2, ga2 * kamp2
ga1     =       0
ga2     =       0

        endin

</CsInstruments>

<CsScore>

f 1 0 512 16 0 512 .8 1
f 3 0 4 -2 .01 .1 .5 .0001
i 1 0 3600
i 5 0 3600

e

</CsScore>
</CsoundSynthesizer> 
