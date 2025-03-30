// Definiamo uno stato per tenere traccia degli acronimi già visti e le loro descrizioni
#let acronimi_visti = state("acronimi-visti", (:))
#let acronimi_info = state("acronimi-info", (:))

// Funzione per gestire gli acronimi
#let acronimo(sigla, descrizione) = {
  // Aggiorniamo la lista completa di acronimi con le descrizioni
  acronimi_info.update(info => {
    if sigla not in info {
      info.insert(sigla, descrizione)
    }
    return info
  })
  
  // Visualizziamo la versione completa solo alla prima occorrenza
  locate(loc => {
    let visti = acronimi_visti.at(loc)
    if sigla in visti {
      // Già mostrato in precedenza, mostra solo la sigla
      [#sigla]
    } else {
      // Prima occorrenza, mostra descrizione completa
      acronimi_visti.update(v => {
        v.insert(sigla, true)
        return v
      })
      [#descrizione (#sigla)]
    }
  })
}

// Funzione per generare la lista degli acronimi
#let lista_acronimi() = {
  locate(loc => {
    let info = acronimi_info.at(loc)
    if info.len() == 0 {
      return
    }
    
    // Otteniamo le sigle in ordine alfabetico
    let sigle = info.keys().sorted()
    
    // Creiamo la lista
    [
      = Lista degli acronimi
      
      #table(
        columns: (auto, auto),
        stroke: none,
        inset: (x: 0.5em, y: 0.3em),
        align: (left, left),
        ..sigle.map(sigla => (
          [*#sigla*], [#info.at(sigla)]
        )).flatten()
      )
    ]
  })
}