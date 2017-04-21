; FileMix4ASC (2010) for realtime Csound5 - by Arthur B. Hunkins
;  ASCII keyboard control (no MIDI); 4 files only
;  1-4 controls/parameters per file (amp, band-pass peak freq, peak gain, speed/freq)
;  Files may be mono or stereo; can have different sample rates, may be a variety of
;   uncompressed types including WAV and AIFF; also Ogg/Vorbis (with Sugar 0.86/
;   Blueberry or later, or Sugar 0.84/Strawberry with updated libsndfile) but not MP3.
;  They must be named soundin.1 (through soundin.4), and in the same folder as this file,
;   or they may be loaded through the Journal (with Sugar 0.84/Strawberry or later).

<CsoundSynthesizer>
<CsOptions>

-odac -+rtaudio=alsa -m0d --expression-opt -b128 -B2048

</CsOptions>                                                    
<CsInstruments>

sr      = 44100
; change sample rate to 48000 (or 32000 if necessary) when 44100 gives no audio.
; (Necessary for Intel Classmate PC and some other systems.)
ksmps   = 100
nchnls  = 2

giparm  chnexport "parms", 1
gkasc	chnexport "ascii", 1

        seed    0
gkasc   init    0
gktime  init    .1
gkamp2  init    0        
gkamp3  init    0        
gkamp4  init    0        
gkamp5  init    0        
gkpfrq2 init    256        
gkpfrq3 init    256       
gkpfrq4 init    256        
gkpfrq5 init    256        
gkpgan2 init    .25
gkpgan3 init    .25
gkpgan4 init    .25
gkpgan5 init    .25
gksped2 init    1        
gksped3 init    1        
gksped4 init    1        
gksped5 init    1        

gitemp  ftgen 2, 0, 512, -5, 200, 512, sr / 13.2

	instr 1

	if (gkasc != 96) goto skip
gktime  =     .1
        kgoto end
skip:
	if ((gkasc < 48) || (gkasc > 57)) goto skip2
gktime  =     gkasc - 48
gktime  =     (gkasc == 48? gktime + 10: gktime)
        kgoto end
skip2:
        if (gkasc != 103) && (gkasc != 104) goto skip3
gkamp2  =       0        
gkamp3  =       0        
gkamp4  =       0        
gkamp5  =       0        
        kgoto end
skip3:
        if (gkasc != 118) && (gkasc != 98) && (gkasc != 110) goto skip4
gktime  =       .1
gkamp2  =       0        
gkamp3  =       0        
gkamp4  =       0        
gkamp5  =       0        
gkpfrq2 =       256        
gkpfrq3 =       256       
gkpfrq4 =       256       
gkpfrq5 =       256       
gkpgan2 =       .25
gkpgan3 =       .25
gkpgan4 =       .25
gkpgan5 =       .25
gksped2 =       1        
gksped3 =       1        
gksped4 =       1        
gksped5 =       1        
        kgoto end
skip4:
        if (gkasc != 97) goto skip5
gkamp2  =    gkamp2 + .5
gkamp2  =    (gkamp2 > 1? 1: gkamp2)   
        kgoto end
skip5:
        if (gkasc != 115) goto skip6
gkamp3  =    gkamp3 + .5
gkamp3  =    (gkamp3 > 1? 1: gkamp3)   
        kgoto end
skip6:
        if (gkasc != 100) goto skip7
gkamp4  =    gkamp4 + .5
gkamp4  =    (gkamp4 > 1? 1: gkamp4)   
        kgoto end
skip7:
        if (gkasc != 102) goto skip8
gkamp5  =    gkamp5 + .5
gkamp5  =    (gkamp5 > 1? 1: gkamp5)   
        kgoto end
skip8:
        if (gkasc != 65) goto skip9
gkamp2  =    gkamp2 - .5
gkamp2  =    (gkamp2 < 0? 0: gkamp2)   
        kgoto end
skip9:
        if (gkasc != 83) goto skip10
gkamp3  =    gkamp3 - .5
gkamp3  =    (gkamp3 < 0? 0: gkamp3)   
        kgoto end
skip10:
        if (gkasc != 68) goto skip11
gkamp4  =    gkamp4 - .5
gkamp4  =    (gkamp4 < 0? 0: gkamp4)   
        kgoto end
skip11:
        if (gkasc != 70) goto skip12
gkamp5  =    gkamp5 - .5
gkamp5  =    (gkamp5 < 0? 0: gkamp5)   
        kgoto end
skip12:
	if giparm == 1 goto end
        if (gkasc != 113) goto skip13
gkpfrq2  =    gkpfrq2 + 128
gkpfrq2  =    (gkpfrq2 > 512? 512: gkpfrq2)   
        kgoto end
skip13:
        if (gkasc != 119) goto skip14
gkpfrq3  =    gkpfrq3 + 128
gkpfrq3  =    (gkpfrq3 > 512? 512: gkpfrq3)   
        kgoto end
skip14:
        if (gkasc != 101) goto skip15
gkpfrq4  =    gkpfrq4 + 128
gkpfrq4  =    (gkpfrq4 > 512? 512: gkpfrq4)   
        kgoto end
skip15:
        if (gkasc != 114) goto skip16
gkpfrq5  =    gkpfrq5 + 128
gkpfrq5  =    (gkpfrq5 > 512? 512: gkpfrq5)   
        kgoto end
skip16:
        if (gkasc != 81) goto skip17
gkpfrq2  =    gkpfrq2 - 128
gkpfrq2  =    (gkpfrq2 < 0? 0: gkpfrq2)   
        kgoto end
skip17:
        if (gkasc != 87) goto skip18
gkpfrq3  =    gkpfrq3 - 128
gkpfrq3  =    (gkpfrq3 < 0? 0: gkpfrq3)   
        kgoto end
skip18:
        if (gkasc != 69) goto skip19
gkpfrq4  =    gkpfrq4 - 128
gkpfrq4  =    (gkpfrq4 < 0? 0: gkpfrq4)   
        kgoto end
skip19:
        if (gkasc != 82) goto skip20
gkpfrq5  =    gkpfrq5 - 128
gkpfrq5  =    (gkpfrq5 < 0? 0: gkpfrq5)   
        kgoto end
skip20:
	if giparm == 2 goto end
        if (gkasc != 106) goto skip21
gkpgan2  =    gkpgan2 + .225
gkpgan2  =    (gkpgan2 > .7? .7: gkpgan2)   
        kgoto end                
skip21:
        if (gkasc != 107) goto skip22
gkpgan3  =    gkpgan3 + .225
gkpgan3  =    (gkpgan3 > .7? .7: gkpgan3)   
        kgoto end                
skip22:
        if (gkasc != 108) goto skip23
gkpgan4  =    gkpgan4 + .225
gkpgan4  =    (gkpgan4 > .7? .7: gkpgan4)   
        kgoto end                
skip23:
        if (gkasc != 59) goto skip24
gkpgan5  =    gkpgan5 + .225
gkpgan5  =    (gkpgan5 > .7? .7: gkpgan5)   
        kgoto end                
skip24:
        if (gkasc != 74) goto skip25
gkpgan2  =    gkpgan2 - .225
gkpgan2  =    (gkpgan2 < .25? .25: gkpgan2)   
        kgoto end                
skip25:
        if (gkasc != 75) goto skip26
gkpgan3  =    gkpgan3 - .225
gkpgan3  =    (gkpgan3 < .25? .25: gkpgan3)   
        kgoto end                
skip26:
        if (gkasc != 76) goto skip27
gkpgan4  =    gkpgan4 - .225
gkpgan4  =    (gkpgan4 < .25? .25: gkpgan4)   
        kgoto end                
skip27:
        if (gkasc != 58) goto skip28
gkpgan5  =    gkpgan5 - .225
gkpgan5  =    (gkpgan5 < .25? .25: gkpgan5)   
        kgoto end                
skip28:
	if giparm == 3 goto end
        if (gkasc != 117) goto skip29
gksped2 =    gksped2 + .05
gksped2  =    (gksped2 > 1.1? 1.1: gksped2)   
        goto end                
skip29:
        if (gkasc != 105) goto skip30
gksped3 =    gksped3 + .05
gksped3  =    (gksped3 > 1.1? 1.1: gksped3)   
        goto end                
skip30:
        if (gkasc != 111) goto skip31
gksped4 =    gksped4 + .05
gksped4  =    (gksped4 > 1.1? 1.1: gksped4)   
        goto end                
skip31:
        if (gkasc != 112) goto skip32
gksped5 =    gksped5 + .05
gksped5  =    (gksped5 > 1.1? 1.1: gksped5)   
        goto end                
skip32:
        if (gkasc != 85) goto skip33
gksped2 =    gksped2 - .05
gksped2  =    (gksped2 < .9? .9: gksped2)   
        goto end                
skip33:
        if (gkasc != 73) goto skip34
gksped3 =    gksped3 - .05
gksped3  =    (gksped3 < .9? .9: gksped3)   
        goto end                
skip34:
        if (gkasc != 79) goto skip35
gksped4 =    gksped4 - .05
gksped4  =    (gksped4 < .9? .9: gksped4)   
        goto end                
skip35:
        if (gkasc != 80) goto end
gksped5 =    gksped5 - .05
gksped5 =    (gksped5 < .9? .9: gksped5)   
end:

gkasc	=    0
	
        endin

        instr 2, 3, 4, 5

        if p1 > 2 goto skip
k1      =       gkamp2
k2      =       gkpfrq2
k3      =       gkpgan2
k4      =       gksped2
Sname   chnget  "file1"
i1      strcmp  Sname, "0"
        if i1 != 0 goto skip2
Sname   =       "soundin.1"
        goto skip2
skip:
        if p1 > 3 goto skip3
k1      =       gkamp3
k2      =       gkpfrq3
k3      =       gkpgan3
k4      =       gksped3
Sname   chnget  "file2"
i1      strcmp  Sname, "0"
        if i1 != 0 goto skip2
Sname   =       "soundin.2"
        goto skip2
skip3:
        if p1 > 4 goto skip4
k1      =       gkamp4
k2      =       gkpfrq4
k3      =       gkpgan4
k4      =       gksped4
Sname   chnget  "file3"
i1      strcmp  Sname, "0"
        if i1 != 0 goto skip2
Sname   =       "soundin.3"
        goto skip2
skip4:
k1      =       gkamp5
k2      =       gkpfrq5
k3      =       gkpgan5
k4      =       gksped5
Sname   chnget  "file4"
i1      strcmp  Sname, "0"
        if i1 != 0 goto skip2
Sname   =       "soundin.4"
skip2:
kamp    lineto  k1, gktime
kamp2   table   kamp * 512, 1
kamp2	=	(kamp2 < .02? 0: kamp2)
kamp2   port    kamp2, .01
ichans  filenchnls Sname
ilen    filelen Sname
ipeak   filepeak Sname
imult   =       8190 / ipeak
kamp2   =       kamp2 * imult
irand   unirand ilen * .75
kbase   lineto  k4, gktime
kbase   =       (giparm == 4? kbase: 1)
        if ichans == 2 goto skip5
a1      diskin2 Sname, kbase, irand, 1
        if giparm > 1 goto skip6
        goto skip7  
skip5:        
a1, a2  diskin2 Sname, kbase, irand, 1
        if giparm > 1 goto skip6
        goto skip7  
skip6:
kfreq   lineto  k2, gktime
kfreq   table   kfreq, 2
kfreq   port    kfreq, .01
kres    lineto  k3, gktime
kres    =       (giparm > 2? kres: .25)
a3,a4,a5 svfilter a1, kfreq, kres, 1
        if ichans == 1 goto skip8
a6,a7,a8 svfilter a2, kfreq, kres, 1
skip8:
        if giparm == 2 goto skip6
kamp2   =       kamp2 + (kamp2 * 3 * (kres - .25))
skip7:         
        if giparm > 1 goto skip9
        outs    a1 * kamp2, (ichans == 1? a1: a2) * kamp2
        goto end
skip9:
        outs    a5 * kamp2, (ichans == 1? a5: a8) * kamp2
end:
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
