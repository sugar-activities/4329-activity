; FileMix4 (2010) for realtime Csound5 - by Arthur B. Hunkins
;  requires MIDI device with 4-16(17) knobs/sliders; 4 files only
;  1-4 controls/parameters per file (amp, band-pass peak freq, peak gain, speed/freq)
;  1 parameter requires 4(5) knobs/sliders; 2 parameters, 8(9); 3 parameters, 12(13);
;   4 parameters, 16(17). The additional controller is optional Master volume.
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
giparm  chnexport "parms", 1

        massign 0, 0
        seed    0
ga1     init    0
ga2     init    0
        
gitemp  ftgen 2, 0, 512, -5, 200, 512, sr / 13.2

        instr 1, 2, 3, 4

        if p1 != 1 goto cont
Sname	chnget	"file1"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.1"
        goto cont2
cont:
        if p1 != 2 goto cont3
Sname	chnget	"file2"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.2"
        goto cont2
cont3:
        if p1 != 3 goto cont4
Sname	chnget	"file3"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.3"
        goto cont2
cont4:                
Sname	chnget	"file4"
i1      strcmp  Sname, "0"
        if i1 != 0 goto cont2
Sname   =       "soundin.4"
cont2:                
        if p1 > 1 igoto skip
gimast  =       ((gichan == 0) && (giparm == 4)? -1: gimast)
skip:
kamp	ctrl7   (gichan == 0? p1: gichan), (gichan == 0? 7: gictrl1 + (p1 - 1)), 0, 1
kamp2   table   kamp * 512, 1
kamp2   port    kamp2, .01
ichans  filenchnls Sname
ilen    filelen Sname
ipeak   filepeak Sname
imult   =       8190 / ipeak
kamp2   =       kamp2 * imult
irand   unirand ilen * .75
; physically set these controllers to .5 after start
kbase   ctrl7   (gichan == 0? p1 + 12: gichan), (gichan == 0? 7: gictrl2 + (p1 + 3)), .9, 1.1
kbase   port    kbase, .01
kbase   =       (giparm == 4? kbase: 1)
        if ichans == 2 goto skip2
a1      diskin2 Sname, kbase, irand, 1
        if giparm > 1 goto skip3
        goto skip4  
skip2:        
a1, a2  diskin2 Sname, kbase, irand, 1
        if giparm > 1 goto skip3
        goto skip4  
skip3:
; physically set these controllers to .5 after start
kfreq   ctrl7   (gichan == 0? p1 + 4: gichan), (gichan == 0? 7: gictrl1 + (p1 + 3)), 0, 512
kfreq   table   kfreq, 2
kfreq   port    kfreq, .01
kres    ctrl7   (gichan == 0? p1 + 8: gichan), (gichan == 0? 7: gictrl2 + (p1 - 1)), .25, .7
kres    port    kres, .01
kres    =       (giparm > 2? kres: .25)
a3,a4,a5 svfilter a1, kfreq, kres, 1
        if ichans == 1 goto skip5
a6,a7,a8 svfilter a2, kfreq, kres, 1
skip5:
        if giparm == 2 goto skip4
kamp2   =       kamp2 + (kamp2 * 3 * (kres - .25))
skip4:         
ga1     =       ga1 + ((giparm == 1? a1: a5) * kamp2)   
ga2     =       ga2 + ((giparm == 1? (ichans == 1? a1: a2): (ichans == 1? a5: a8)) * kamp2)  

        endin
   
        instr 5

        if (gichan > 0) && (gimast > -1) goto skip
        if (giparm < 4) && (gichan == 0) && (gimast > -1) goto skip
kamp2   =       1
        goto skip2 
skip:
kamp	ctrl7   (gichan == 0? gimast: gichan), (gichan == 0? 7: gimast), 0, 1
kamp2   table   kamp * 512, 1
kamp2   port    kamp2, .01
skip2:
        outs    ga1 * kamp2, ga2 * kamp2
ga1     =       0
ga2     =       0

        endin

</CsInstruments>

<CsScore>

f 1 0 512 16 0 512 .8 1
i 1 0 3600
i 2 0 3600
i 3 0 3600
i 4 0 3600
i 5 0 3600

e

</CsScore>
</CsoundSynthesizer> 
 
