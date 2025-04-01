
= Introduzione

Il traffico internet generato da flussi video, in streaming o on-demand, rappresenta una parte significativa del traffico totale mondiale ammontando al 65% (2022) #cite(<c1>) tra dispositivi fissi e mobili. È senz'altro destinato a crescere ulteriormente, in particolare grazie all'emersione di contenuti short-form e alla diffusione di nuove tecnologie come la realtà aumentata.

Il solo video streaming in diretta aggiunge ulteriori sfide che devono integrarsi nella moderna architettura di internet.
Si parla di OTT #footnote("https://en.wikipedia.org/wiki/Over-the-top_media_service [28-03-2025]") per riferirsi alla fornitura di servizi multimediali attraverso Internet, a differenza delle tradizionali trasmissioni via satellite o delle reti Broadband gestite da operatori specifici.

L'integrazione di Internet nei processi di distribuzione ha trasformato radicalmente il panorama dei media, spingendo sia i broadcaster tradizionali che le piattaforme digitali a innovare continuamente per soddisfare le esigenze di un pubblico in evoluzione.

== Contesto e motivazione
Lo sviluppo di protocolli per la distribuzione di contenuti multimediali al giorno d'oggi si è conformato all'utilizzo di HTTP (HyperText Transfer Protocol).
Seppur non disegnato originariamente per il trasporto di media, molti aspetti lo rendono facilmente scalabile e di facile adozione.

Per questi motivi, MPEG ha portato alla formulazione degli standard CMAF #footnote("https://www.gumlet.com/learn/what-is-cmaf") e del protocollo DASH #cite(<1943552.1943572>), sancendo definitivamente HTTP come protocollo dominante nel settore del video streaming.
Questo ha accelerato lo sviluppo di Reti per la Distribuzione di Contenuti (CDN), che, attraverso una rete di server distribuiti geograficamente #footnote("https://www.akamai.com/why-akamai/global-infrastructure"), migliorano la velocità e l'affidabilità nella consegna dei contenuti, riducendo la latenza e gestendo efficacemente i picchi di traffico.

Seppur le CDN abbiano migliorato la qualità del servizio, l'*imprevedibilità* dell'intera tratta client-server, nelle omonime architetture, è intrinseca nella definizione di internet. Questo mina alla QoE (Quality of Experience) un parametro che seppur soggettivo si riflette direttamente in dinamiche indesiderate. 

Per cui mentre tramite i provider CDN fondano la loro efficienza sullo sviluppo di algoritmi per il controllo di congestione (come BBR #footnote("https://blog.apnic.net/2019/11/01/bbr-evaluation-at-a-large-cdn")), sui client si sono studiati algoritmi per il Bitrate Adattivo (ABR) in modo da reagire efficacemente alla banda disponibile.

Sono stati spesi ampi sforzi nello sviluppo di algoritmi ABR. Si passa da algoritmi basati sullo stato del client #cite(<2619239.2626296>), fino a soluzioni inspirate direttamente a sistemi di controllo come controllori PID #cite(<7552948>)

== Osservazioni
Seppur questi algoritmi funzionino correttamente in teoria, la loro applicazione in campo reale è soggetta a forti variabilità oltre che del canale internet, anche della variabilità del contenuto video trasmesso.

È noto #cite(<5453873>) come gli algoritmi ABR performino discretamente bene qualora il video sia codificato a Bitrate costante, aspetto che mina all'efficienza della trasmissione portando a eventuale congestione, aspetto che mina fortemente alla QoE manifestandosi sotto forma di interruzioni.

== Obiettivi
Si vuole consentire quindi all'algoritmo ABR di eseguire una scelta informata con l'ulteriore variabile proprio delle caratteristiche riguardo il flusso video che riempirà il playout buffer del client.

Per arrivare a conclusioni sperimentali quindi si è realizzato un software di ingesting capace di estrarre dal flusso video codificato le dimensioni di frame o porzioni di video compresso.

Il client quindi avrà informazioni utili riguardo il potenziale impegno del canale, così da prendere una scelta sicura e fattibile rispetto alle capacità disponibili. Evidenze sperimentali dimostrano che si attenua indirettamente, ma non si elimina, fluttuazioni della banda disponibile per una riproduzione fluida. Altre sfide rimangono come l'oscillazione degli input di controllo, ma viene affrontata una soluzione in termini di compromessi e parametri di costo.

== Contributi
Lo svantaggio principale di questa soluzione è l'ulteriore latenza introdotta. Tuttavia il beneficio quale la conoscenza dello stato del sistema corrente e futuro può portare alla riduzione del buffer locale del client e quindi latenze pari a implementazioni standard di soluzioni esistenti.

[Breve formulazione e discussione oggettiva dei risultati]