

// Anteprima indice

= Stato dell'arte
== Common Media Application Format
Deep-dive su come CMAF facilita la distribuzione e consente il bitrate adattivo
== Algoritmi di Adaptive Bitrate
come funziona, stima delle risorse, scheduling e modulo decisionale
== Flusso tipico con DASH
Si illustra in breve il ruolo del manifest (ad esempio sincronia client-server, url e sequenze) e si discute il funzionamento attraverso i log di dash.js (ABR e il suo Scheduler in particolare) con l'obiettivo di comprendere in quale punto focalizzarsi e inserire il nuovo modulo

= Modello del problema
== Linearizzazione del sistema
considero come modello del sistema il buffer del player dato che è lineare, rispetto all'intero internet. individuo gli aspetti trascurati dopo la linearizzazione (eg dinamiche ingovernabili come bufferbloat, routing dinamico, trunk congestionati da parte di ISP e POP nella tratta internet, c'è un paper carino di Netflix sulle fasce orarie), primo fra tutti la latenza da introdurre che si traduce in ritardo nelle decisioni. altri problemi derivano da TCP (ritrasmissioni da protocollo, slow-start).

espongo variabili del sistema (rtt, throughput, congestion window); dato che non le conosco, posso dedurle impiegando un buffer, ottima linearizzazione se si rimane in un punto di equilibrio definito a steady-state. espongo le equazioni differenziali lineari dello stato del buffer

Dato che è impossibile vedere nel mezzo tra client e server, evidenzio come la linearizzazione basata su buffer sia soddisfacente, oltre tutti i difetti
== Model Predictive Control
Cenni di teoria sul controllo predittivo e la sua applicazione ai sistemi dinamici
== Controllore
Conoscendo le varianti delle richieste future posso influenzare efficacemente l'input di controllo, in MPC è chiamato orizzonte. Si fonda sulla definizione di una funzione di costo, dipendente dagli stati del sistema e da pesi. Questi riflettono gli obiettivi e constraints tramite penalità riguardo il valore dell'errore. 
== Soluzione ad alto livello
Qui spiego i requisiti della soluzione: evidenzio come indipendentemente dal codec come frammenti adiancenti (gruppi di frame interdipendenti) abbiano dimensioni molto distinte in base al contenuto (mostro asset di esempio, da video statici, in movimento, transizioni)
Giustifico così l'uso delle dimensioni in KB dei frammenti come i dati nell'orizzonte definito
== Definizione della Funzione di costo
- Un parametro della funzione di costo è la stima della banda (fatta con EMWA) 
- Un peso della funzione di costo è lo stato osservabile del buffer (occupancy minore rende più costosi esponenzialmente qualità maggiori)

= Implementazione e sviluppo
== Pipeline tipica streaming video
Illustrazione delle latenze, Brevi cenni sulla codifica video, come avviene il playback grazie ai container (esempio distribuzione live sfruttando mp4)
=== Produzione
Come fare packaging e frammentazione con `ffmpeg`, come realizzare CMAF
=== Distribuzione
Web server e CDN (come si istruisce il caching)
== Requisiti funzionali
=== Golang
perché Go rispetto ai requisiti
=== Gestione della concorrenza
concorrenza tramite routine & channels, mutexes per strutture dati, integrazione con syscall linux efficienti
=== Software di ingesting
come ho integrato gli aspetti sopra; realizzazione web server, analisi del bytestream intelligente per realizzare l'ingesting
== Player web
=== Stato dell'arte dei browser
Media Source Extension
=== Integrazione con TypeScript
Integrazione dell'ABR (modulo di scheduling e modulo decisionale)

= Validazione e test
== Ambiente di test
Setup Testbed con `traffic control`
== Metriche
[ho qualche dubbio su come valutare la QoE] mostro il rate di rebuffering, buffer occupancy, rendition scelte su x-minuti di playback e in particolare in base al tipo di contenuto 
== Confronti
con ABR lineari

= Discussione
== Analisi dei risultati
evidenze sull'"intelligenza" del controllore

l'algoritmo è particolarmente oneroso ma è possibile abbassare il sample rate o accorciare il receding horizon, è anche possibili renderli dinamici tramite meccanismi a soglie in base alla salute generale del sistema (buffer e download lenti)

come tarare i parametri in modo da, ad esempio, diminuire l'aggressività del controllore (e quindi le oscillazioni)
== Sviluppi futuri
Discussione sulla possibile integrazione con DASH, DRM e tracce sottotitoli.