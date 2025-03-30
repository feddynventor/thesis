#import "front.typ": front
#import "utils.typ": lista_acronimi

#set text(lang: "it")
#set page(
  width: 210mm,
  height: 297mm,
  margin: (
    inside: 2.5cm,
    outside: 2cm,
    y: 1.75cm
  ),
)

// Bibliography object
// #let refs = bibliography("refs.bib")

#show: front.with(
  title: "Sistemi di controllo predittivi\nper la distribuzione video in streaming a bassa latenza:\nottimizzazione del processo di ingesting con supporto alla scalabilità in internet tramite CDN", 
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
  // co-supervisor: (),
  // bib: refs,
)

#include "capitoli/abstract.typ"
#include "capitoli/introduzione.typ"

#lista_acronimi()