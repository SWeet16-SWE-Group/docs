import React, { useEffect, useState } from "react";
import { Link } from 'react-router-dom';
import axiosClient from '../axios-client.js';
import { useStateContext } from '../contexts/ContextProvider.jsx';

function Prenotazione(a){
  const url = (id) => `/dettagliprenotazionecliente/${id}`;
  return (<tr key={a.id}>
    <td>{a.orario}</td>
    <td>{a.nome}</td>
    <td>{a.numero_inviti}</td>
    <td>{a.stato}</td>
      {a.stato !== 'Rifiutata' &&
          <td><Link to={url(a.id)}>Dettagli</Link></td>
      }
  </tr>);
}

export default function ClienteDashboard() {

    const {profile} = useStateContext()
    const [prenotazioni, setPrenotazioni] = useState(null);

    const fetchPrenotazioni = () => {
      axiosClient.get(`/dashboard_c/${profile}`).then(
        data => setPrenotazioni(data.data)
      );
    };

    useEffect(fetchPrenotazioni, []);

    return (
        <table className="table">
            <thead>
                <tr>
                    <th>Orario</th>
                    <th>Ristoratore</th>
                    <th>Numero Inviti</th>
                    <th>Stato</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                {prenotazioni && prenotazioni.map(Prenotazione)}
            </tbody>
        </table>
    );
}
