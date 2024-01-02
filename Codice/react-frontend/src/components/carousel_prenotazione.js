import React, { Component } from 'react';
import { Carousel } from 'react-bootstrap';
import axios from 'axios';

class FormPrenotazione extends Component {
  constructor(props) {
    super(props);
    this.state = {
      cliente: [],
      ristoranti: [],
      ristorantifiltrati: [],
      ristoranteselezionato: [],
      tavoli: [],
      tavoloselezionato: [],
      orari: [],
      cerca: "",
      numeropersone: "",
      data: "",
      orarioarrivo: "",
      orariopartenza: "",
      fascia: "",
      page: 0,
      page0compiled: false,
      page1compiled: false,
      page2compiled: false,
      page3compiled: false,
      page4compiled: false,
    };
    this.filterList = this.filterList.bind(this);
    this.handleSearch = this.handleSearch.bind(this);
    this.handleRadioChange = this.handleRadioChange.bind(this);
    this.handleRadio2Change = this.handleRadio2Change.bind(this);
    this.FasciaChange = this.FasciaChange.bind(this);
    this.handleNumberChange = this.handleNumberChange.bind(this);
    this.handleDateChange = this.handleDateChange.bind(this);
    this.handleTimeAClick = this.handleTimeAClick.bind(this);
    this.handleTimePClick = this.handleTimePClick.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentDidMount() {
    axios.get('http://localhost:8888/select_multiple_ristorante.php').then(response =>
      this.setState({ ristoranti: response.data}));
    axios.get('http://localhost:8888/select_single_cliente.php').then(response =>
      this.setState({ cliente: response.data}));
  }


  componentSendData(){
    if((this.state.numeropersone !== "") && (this.state.ristoranteselezionato[0].ID_ristorante !== "") && (this.state.data !== ""))
    {
    const tavolo = [
      {
      id_ristorante : this.state.ristoranteselezionato[0].ID_ristorante,
      num_posti : this.state.numeropersone,
      giorno : this.state.data
      } 
    ]
    
     axios
      .post("http://localhost:8888/select_multiple_tavolo.php", tavolo[0])
      .then(response => {
        this.setState({ tavoli: response.data});
    }) 
    }

  }

  handleSelect = (selectedPage) => {
    this.setState({ page: selectedPage });
  };

  handleSearch = (event) => {
    const cerca = event.target.value.toLowerCase();
    this.setState({ cerca }, () => this.filterList());
  }

  filterList() {
    let ristoranti = this.state.ristoranti;
    let cerca = this.state.cerca;

    ristoranti = ristoranti.filter(function(ristoranti) {
      if(cerca!=="")
        return ristoranti.Ragione_sociale.toLowerCase().indexOf(cerca) !== -1;
    });
    this.setState({ ristorantifiltrati: ristoranti });
  }

  handleRadioChange = (event) => { 
    let id = event.target.value;
    this.state.ristoranteselezionato[0] = this.state.ristoranti[id];
    this.state.page0compiled = true;
    document.getElementsByClassName("carousel-control-next")[0].style.display="flex";
  }

  handleDateChange = (event) => { 
    let data = event.target.value;
    this.state.data = data;
    if(this.state.fascia !== "") 
    {
      this.state.page1compiled=true;
      document.getElementsByClassName("carousel-control-next")[0].style.display="flex";
    }
    else
    {
      this.state.page1compiled=false;
      document.getElementsByClassName("carousel-control-next")[0].style.display="none";
    }

    event.preventDefault();

    this.componentSendData();

  }

  handleRadio2Change = (event) => { 
    this.state.fascia=event.target.value;
    this.FasciaChange();
    if(this.state.data !== "") 
    {
      this.state.page1compiled=true;
      document.getElementsByClassName("carousel-control-next")[0].style.display="flex";
    }
    else
    {
      this.state.page1compiled=false;
      document.getElementsByClassName("carousel-control-next")[0].style.display="none";
    }
  }


  handleTimeAClick = (event) => { 
    let oraa = event.target.value;
    let id = event.target.id;
    this.state.orarioarrivo = oraa;
    if(oraa !== "")
    {
      this.state.page3compiled=true;
      document.getElementsByClassName("carousel-control-next")[0].style.display="flex";
      if(document.getElementsByClassName("arrivo")[0])
      {
        document.getElementsByClassName("arrivo")[0].classList.remove("active");
        document.getElementsByClassName("arrivo")[0].classList.remove("arrivo");
      }
      document.getElementById(id).classList.add("active");
      document.getElementById(id).classList.add("arrivo");
    }
    else
    {
      this.state.page3compiled=false;
      document.getElementsByClassName("carousel-control-next")[0].style.display="none";
    }
  }

  handleTimePClick = (event) => { 
    let orap = event.target.value;
    let id = event.target.id;
    this.state.orariopartenza = orap;
    if(orap !== "")
    {
      this.state.page4compiled=true;
      document.getElementsByClassName("carousel-control-next")[0].style.display="flex";
      if(document.getElementsByClassName("partenza")[0])
      {
        document.getElementsByClassName("partenza")[0].classList.remove("active");
        document.getElementsByClassName("partenza")[0].classList.remove("partenza");
      }
      document.getElementById(id).classList.add("active");
      document.getElementById(id).classList.add("partenza");
    }
    else
    {
      this.state.page4compiled=false;
      document.getElementsByClassName("carousel-control-next")[0].style.display="none";
    }
  }

  FasciaChange()
  {
    this.state.orari.length=0;
    if(this.state.fascia==="pranzo")
    {
      let apertura = this.state.ristoranteselezionato[0].Orario_apertura_mat;
      let chiusura = this.state.ristoranteselezionato[0].Orario_chiusura_mat;

      let aperturaParts = apertura.split(":");    
      let chiusuraParts = chiusura.split(":");  

      let a = new Date();
      let c = new Date();

      a.setHours(+aperturaParts[0]);    
      a.setMinutes(+aperturaParts[1]); 

      c.setHours(+chiusuraParts[0]);    
      c.setMinutes(+chiusuraParts[1]);
    
      
      while((a.getHours()<=c.getHours()))
      {
        let item=a.getHours() + ":" + (a.getMinutes() === 0 ? "00" : a.getMinutes());
        this.state.orari.push(item);
        a.setMinutes(a.getMinutes()+15);
      }
      while((a.getMinutes()<=c.getMinutes()))
      {
        let item=a.getHours() + ":" + (a.getMinutes() === 0 ? "00" : a.getMinutes());
        this.state.orari.push(item);
        a.setMinutes(a.getMinutes()+15,0,0);
      }
    }
    else if(this.state.fascia==="cena")
    {
      let apertura = this.state.ristoranteselezionato[0].Orario_apertura_pom;
      let chiusura = this.state.ristoranteselezionato[0].Orario_chiusura_pom;

      let aperturaParts = apertura.split(":");    
      let chiusuraParts = chiusura.split(":");  

      let a = new Date();
      let c = new Date();

      a.setHours(+aperturaParts[0]);    
      a.setMinutes(+aperturaParts[1]); 

      c.setHours(+chiusuraParts[0]);    
      c.setMinutes(+chiusuraParts[1]);
      
      while((a.getHours()<=c.getHours()))
      {
        let item=a.getHours() + ":" + (a.getMinutes() === 0 ? "00" : a.getMinutes());
        this.state.orari.push(item);
        a.setMinutes(a.getMinutes()+15);
      }
      while((a.getMinutes()<=c.getMinutes()))
      {
        let item=a.getHours() + ":" + (a.getMinutes() === 0 ? "00" : a.getMinutes());
        this.state.orari.push(item);
        a.setMinutes(a.getMinutes()+15,0,0);
      }
    }
  }

  handleNumberChange = (event) => {
    let num = event.target.value;
    if(num==="")
    {
      document.getElementsByClassName("carousel-control-next")[0].style.display="none";
      this.state.page2compiled = false;
    }
    else
    {
      this.state.numeropersone = num;
      document.getElementsByClassName("carousel-control-next")[0].style.display="flex";
      this.state.page2compiled = true;

      event.preventDefault();

      this.componentSendData();
      
    }
  }

  compareAllOrari = (orario, index) => {
    const { tavoli } = this.state;

      const tavoliValues = tavoli.map((tavolo) => ({
        tavoloArrivo: tavolo.Orario_arrivo,
        tavoloPartenza: tavolo.Orario_partenza,
        isBetween: this.checkTimeOverlap(tavolo.Orario_arrivo, tavolo.Orario_partenza, orario)
      }))
      const ok = tavoliValues.every((tavolo) => tavolo.isBetween);

      if(ok===false || this.state.tavoli.length===0)
      {
        const tavoloValido = tavoliValues.find((tavolo) => !tavolo.isBetween);
        if(tavoloValido)
        {
          const TavoloValido = tavoli[tavoliValues.indexOf(tavoloValido)];
          this.state.tavoloselezionato[0]=TavoloValido;
        }
        if(index+1===this.state.orari.length)
        {
          return;
        }
        else
        {         
          if((index+1)%4 === 0)
          {
            return (
              <>
                <input id={"arrivo"+index} name={"arrivo"+index} type="button" className="btn btn-outline-primary m-2" value={orario} onClick={this.handleTimeAClick}/>
                <br />
              </>
            )
          }
          else
          {
            return <input id={"arrivo"+index} name={"arrivo"+index} type="button" className="btn btn-outline-primary m-2" value={orario} onClick={this.handleTimeAClick}/>
          }
        }
      }
      else
      {
        if(index+1===this.state.orari.length)
        {
          return;
        }
        else
        {         
          if((index+1)%4 === 0)
          {
            return (
              <>
                <input id={"arrivo"+index} name={"arrivo"+index} type="button" className="btn btn-outline-secondary m-2" value={orario} disabled onClick={this.handleTimeAClick}/>
                <br />
              </>
            )
          }
          else
          {
            return <input id={"arrivo"+index} name={"arrivo"+index} type="button" className="btn btn-outline-secondary m-2" value={orario} disabled onClick={this.handleTimeAClick}/>
          }
        }
    }
  };

  checkTimeOverlap = (arrivo, partenza, orario) => {
    const arrivoTime = new Date(`2000-01-01 ${arrivo}`);
    const partenzaTime = new Date(`2000-01-01 ${partenza}`);
    const orarioTime = new Date(`2000-01-01 ${orario}`);

    return orarioTime >= arrivoTime && orarioTime <= partenzaTime;   
  };

  compareAfterOrari = (orario, index) => {
    const { orarioarrivo } = this.state;

      const ok = this.checkTimeAfter(orarioarrivo, orario);

      if(ok===false || this.state.tavoli.length===0)
      { 
        if(index===0)
        {
          return;
        }
        else
        {        
          if((index)%4 === 0)
          {
            return (
              <>
                <input id={"partenza"+index} name={"partenza"+index} type="button" className="btn btn-outline-primary m-2" value={orario} onClick={this.handleTimePClick}/>
                <br />
              </>
            )
          }
          else
          {
            return <input id={"partenza"+index} name={"partenza"+index} type="button" className="btn btn-outline-primary m-2" value={orario} onClick={this.handleTimePClick}/>
          }
        }
      }
      else
      {
        if(index===0)
        {
          return;
        }
        else
        {        
          if((index)%4 === 0)
          {
            return (
              <>
                <input id={"partenza"+index} name={"partenza"+index} type="button" className="btn btn-outline-secondary m-2" value={orario} disabled onClick={this.handleTimePClick}/>
                <br />
              </>
            )
          }
          else
          {
            return <input id={"partenza"+index} name={"partenza"+index} type="button" className="btn btn-outline-secondary m-2" value={orario} disabled onClick={this.handleTimePClick}/>
          }
        }
    }
  };

  checkTimeAfter = (arrivo, orario) => {
    const arrivoTime = new Date(`2000-01-01 ${arrivo}`);
    const orarioTime = new Date(`2000-01-01 ${orario}`);

    return orarioTime <= arrivoTime;   
  };

  handleSubmit = (event) => {
    event.preventDefault();

    const cliente = this.state.cliente[0].ID_cliente;
    const tavolo = this.state.tavoloselezionato[0].ID_tavolo;
    const ristorante = this.state.ristoranteselezionato[0].ID_ristorante;
    const numero = this.state.numeropersone;
    const username = this.state.cliente[0].Username;
    const data = this.state.data;
    const inizio = this.state.orarioarrivo;
    const fine = this.state.orariopartenza;
    const cod_tavolo = this.state.tavoloselezionato[0].Codice;
    const posti_tavolo = this.state.tavoloselezionato[0].Num_posti;

    const insert = [
      {
      id_cliente : cliente,
      id_tavolo : tavolo,
      id_ristorante : ristorante,
      numero_persone : numero,
      partecipanti : username,
      giorno : data,
      arrivo: inizio,
      partenza: fine,
      codice: cod_tavolo,
      posti: posti_tavolo
      }
    ]

    axios
      .post("http://localhost:8888/insert_prenotazione.php", insert[0])
  };


  render() {
    const { page } = this.state;

      if(document.getElementsByClassName("carousel-control-prev")[0] && document.getElementsByClassName("carousel-control-next")[0])
      {
        if(page === 0 && this.state.page0compiled === false)
        {
          document.getElementsByClassName("carousel-control-prev")[0].style.display="none";
          document.getElementsByClassName("carousel-control-next")[0].style.display="none";
        }
        else if(page === 0 && this.state.page0compiled === true) 
        {
          document.getElementsByClassName("carousel-control-prev")[0].style.display="none";
          document.getElementsByClassName("carousel-control-next")[0].style.display="flex";
        }
        else if((page === 1 && this.state.page1compiled === false) 
              || (page === 2 && this.state.page2compiled === false)
              || (page === 3 && this.state.page3compiled === false)
              || (page === 4 && this.state.page4compiled === false))
        {
          document.getElementsByClassName("carousel-control-prev")[0].style.display="flex";
          document.getElementsByClassName("carousel-control-next")[0].style.display="none";
        }
        else if((page === 1 && this.state.page1compiled === true) 
              || (page === 2 && this.state.page2compiled === true)
              || (page === 3 && this.state.page3compiled === true)
              || (page === 4 && this.state.page4compiled === true))
        {
          document.getElementsByClassName("carousel-control-prev")[0].style.display="flex";
          document.getElementsByClassName("carousel-control-next")[0].style.display="flex";
        }
        else if(page === 5)
        {
          document.getElementsByClassName("carousel-control-prev")[0].style.display="flex";
          document.getElementsByClassName("carousel-control-next")[0].style.display="none";
        }
    }
    return (
        <form onSubmit={this.handleSubmit}>
        <Carousel activeIndex={page} onSelect={this.handleSelect} className="container-fluid p-auto w-75 border rounded border-2 margin-top h-auto" autoPlay={false} interval={null} controls={true} indicators={false}>
          <Carousel.Item>
            <h1 className="my-4 d-flex justify-content-center">PRENOTAZIONE</h1>
                            <div className="m-5">
                              <label htmlFor="ricerca">Trova un ristorante:</label>
                              <input type="text" className="form-control mb-3" name="ricerca" id="ricerca" placeholder="Cerca" value={this.state.cerca} onChange={this.handleSearch}/>
                              {this.state.ristorantifiltrati.map((rs, index) => (
                              <div key={index}>
                                <input type="radio" className="mb-2 mr-1" id="seleziona_rist" name="seleziona_rist" value={index} onClick={this.handleRadioChange}/> <label htmlFor="seleziona_rist" className="text-break">{rs.Ragione_sociale + ", " + rs.Citta}</label>
                              </div>
                              ))}
                            </div>
          </Carousel.Item>
          <Carousel.Item>
            <h1 className="my-4 d-flex justify-content-center">PRENOTAZIONE</h1>
                            <div>
                                <div className="m-5">
                                <label htmlFor="data_prenotazione">Seleziona il giorno:</label>
                                <input type="date" className="form-control" name="data_prenotazione" id="data_prenotazione" onChange={this.handleDateChange} />
                                </div>
                                <div className="m-5">       
                                {this.state.ristoranteselezionato.map((rs, index) => (
                                  <div key={index}>
                                    <label htmlFor="fascia">Seleziona una fascia oraria:</label>
                                    <div>
                                      <input type="radio" className="mb-2 mr-1" id="fascia" name="fascia" value="pranzo" onClick={this.handleRadio2Change}/> <span>Pranzo ({rs.Orario_apertura_mat} - {rs.Orario_chiusura_mat})</span>
                                    </div>
                                    <div>
                                      <input type="radio" className="mb-2 mr-1" id="fascia" name="fascia" value="cena" onClick={this.handleRadio2Change}/> <span>Cena ({rs.Orario_apertura_pom} - {rs.Orario_chiusura_pom})</span>
                                    </div>
                                  </div>
                                ))}
                                </div>
                              </div>
          </Carousel.Item>
          <Carousel.Item>
            <h1 className="my-4 d-flex justify-content-center">PRENOTAZIONE</h1>
                            <div className="m-5">
                              <label htmlFor="num_persone">Seleziona il numero di persone:</label>
                              <input type="number" className="form-control" name="num_persone" id="num_persone" min="1" onChange={this.handleNumberChange} />
                            </div>
          </Carousel.Item>
          <Carousel.Item>
            <h1 className="my-4 d-flex justify-content-center">PRENOTAZIONE</h1>
                <div className="container-fluid my-4 text-center">
                <h3 className="my-4">Seleziona l'orario di arrivo</h3>
                  {this.state.orari.map((rs, index) => (
                      <span key={index} className="form-group">
                          {this.compareAllOrari(rs, index)}
                      </span>
                  ))}
                </div>
          </Carousel.Item>
          <Carousel.Item>
            <h1 className="my-4 d-flex justify-content-center">PRENOTAZIONE</h1>
                <div className="container-fluid my-4 text-center">
                <h3 className="my-4">Seleziona l'orario di partenza</h3>
                  {this.state.orari.map((rs, index) => (
                      <span key={index} className="form-group">
                          {this.compareAfterOrari(rs, index)}
                      </span>
                  ))}
                </div>
          </Carousel.Item>
          <Carousel.Item>
            <h1 className="my-4 d-flex justify-content-center">PRENOTAZIONE</h1>
                <div className="container-fluid my-4 text-center">
                  <h3 className="my-4">Informazioni prenotazione</h3>
                  {this.state.ristoranteselezionato.map((rs, index) => (
                  <h5 key={index} className="my-2">Ristorante: {rs.Ragione_sociale}, {rs.Indirizzo}, {rs.CAP} {rs.Citta} </h5>
                  ))}
                  <h5 className="my-3">Data: {this.state.data}</h5>
                  <h5 className="my-3">Orari: {this.state.orarioarrivo} - {this.state.orariopartenza}</h5>
                  <h5 className="my-3">Numero di persone: {this.state.numeropersone}</h5>
                  <button type="submit" className="btn btn-primary btn-lg w-100 mt-3">PRENOTA</button>
                </div>
          </Carousel.Item>
          </Carousel>
        </form>
      );
    }
}
    
export default FormPrenotazione;