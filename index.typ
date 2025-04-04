#import "front.typ": front

#set text(lang: "it")
#set page(
  width: 210mm,
  height: 297mm,
)

#pagebreak()  // fix export SVG

#show: front.with(
  title: "Sistemi di controllo predittivi per la distribuzione video in streaming: ottimizzazione del processo di ingesting tramite Golang e TypeScript con supporto alla scalabilità in internet tramite CDN", 
  // title: "Sistemi di controllo predittivi\nper la distribuzione video in streaming a bassa latenza:\nimplementazione di un software di ingesting in Golang\ne un player per browser in TypeScript\ncon supporto alla scalabilità in internet tramite CDN", 
  candidate:(
    name: "Fedele Cavaliere",
  ),
  date: "2023/2024", 
  university: "POLITECNICO DI BARI",
  department: "DIPARTIMENTO DI INGEGNERIA ELETTRICA E DELL'INFORMAZIONE",
  course: "Corso di Laurea in Ingegneria Informatica e dell’Automazione",
  logo: image("assets/Poliba.png", width: 30%),
  supervisor: "Prof. Luca De Cicco",
  lang: "it",
  bib: bibliography("bibliography.bib"),
  // co-supervisor: (),
)

#include "capitoli/abstract.typ"
#include "capitoli/introduzione.typ"

#include "bozza-indice.typ"