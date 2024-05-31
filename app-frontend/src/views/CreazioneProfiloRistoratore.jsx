import React, { useState } from 'react';
import axiosClient from '../axios-client.js';
import { useStateContext } from '../contexts/ContextProvider.jsx';

export default function CreazioneProfiloRistoratore() {
    const { setNotificationStatus, setNotification } = useStateContext();

    const [formData, setFormData] = useState({
        user: localStorage.getItem('USER_ID'),
        nome: '',
        indirizzo: '',
        telefono: '',
        capienza: '',
        orario: ''
    });
    const [errors, setErrors] = useState([]);

    const handleChange = (e) => {
        setFormData({
            ...formData,
            [e.target.name]: e.target.value
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setErrors([]);
        try {
            const response = await axiosClient.post('/crea-ristoratore', formData);
            setNotificationStatus('success');
            setNotification('Account ristoratore creato con successo');
            setFormData({
                user: localStorage.getItem('USER_ID'),
                nome: '',
                indirizzo: '',
                telefono: '',
                capienza: '',
                orario: ''
            });
        } catch (error) {
            if (error.response) {
                setErrors(Object.values(error.response.data.errors || {}));
                setNotificationStatus('error');
                setNotification('Errore nella creazione dell\'account ristoratore');
            } else {
                setErrors(['C\'è stato un errore, riprova.']);
                setNotificationStatus('error');
                setNotification('C\'è stato un errore, riprova.');
            }
        }
    };

    return (
        <div className="container mt-5">
            <h3>Crea account ristoratore</h3>
            {errors.length > 0 && (
                <div className="alert alert-danger">
                    <ul>
                        {errors.map((error, index) => <li key={index}>{error}</li>)}
                    </ul>
                </div>
            )}
            <form onSubmit={handleSubmit}>
                <div className="mb-3">
                    <label htmlFor="nome">Nome</label>
                    <input
                        type="text"
                        className="form-control"
                        id="nome"
                        name="nome"
                        value={formData.nome}
                        onChange={handleChange}
                        required
                    />
                </div>
                <div className="mb-3">
                    <label htmlFor="indirizzo">Indirizzo</label>
                    <input
                        type="text"
                        className="form-control"
                        id="indirizzo"
                        name="indirizzo"
                        value={formData.indirizzo}
                        onChange={handleChange}
                        required
                    />
                </div>
                <div className="mb-3">
                    <label htmlFor="telefono">Telefono</label>
                    <input
                        type="text"
                        className="form-control"
                        id="telefono"
                        name="telefono"
                        value={formData.telefono}
                        maxLength="10"
                        onChange={handleChange}
                        required
                    />
                </div>
                <div className="mb-3">
                    <label htmlFor="capienza">Capienza</label>
                    <input
                        type="number"
                        className="form-control"
                        id="capienza"
                        name="capienza"
                        min="1"
                        value={formData.capienza}
                        onChange={handleChange}
                        required
                    />
                </div>
                <div className="mb-3">
                    <label htmlFor="orario">Orario apertura - chiusura</label>
                    <input
                        type="text"
                        className="form-control"
                        id="orario"
                        name="orario"
                        value={formData.orario}
                        onChange={handleChange}
                        pattern="\d{2}:\d{2} - \d{2}:\d{2}"
                        placeholder="19:30 - 20:30"
                        title="Inserisci l'orario nel formato 19:30 - 20:30"
                        required
                    />
                </div>
                <div>
                    <button type="submit" className="btn btn-primary me-2">Conferma</button>
                    <button type="button" className="btn btn-secondary" onClick={() => setFormData({
                        user: localStorage.getItem('USER_ID'),
                        nome: '',
                        indirizzo: '',
                        telefono: '',
                        capienza: '',
                        orario: ''
                    })}>Annulla</button>
                </div>
            </form>
        </div>
    );
}
