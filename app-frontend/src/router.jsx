import {createBrowserRouter, Navigate} from "react-router-dom";
import SignUp from "./views/SignUp.jsx";
import Login from "./views/Login";
import NotFound from "./views/NotFound.jsx";
import AuthenticatedLayout from "./components/AuthenticatedLayout";
import GuestLayout from "./components/GuestLayout";
import ClientLayout from "./components/ClientLayout"
import RestaurantLayout from "./components/RestaurantLayout"
import ModificaInfoAccount from "./views/ModificaInfoAccount";
import CreazioneProfiloRistoratore from "./views/CreazioneProfiloRistoratore.jsx";
import ModificaProfiloRistoratore from "./views/ModificaProfiloRistoratore.jsx";
import newClient from "./components/NewClient.jsx";
import EditClient from "./views/EditClient.jsx";

const router = createBrowserRouter([
    {
        path: '/',
        element: <AuthenticatedLayout />,
        children: [
            /*
            {
                path: '/selezionaprofilo',
                element: <SelezionaProfilo />
            }*/
            {
                path: '/newClient',
                element: <newClient />
            },
            {
                path: '/creazioneprofiloristoratore',
                element: <CreazioneProfiloRistoratore />
            },
            {
                path: '/editClient',
                element: <EditClient />
            },
            {
                path: '/modificaprofiloristoratore',
                element: <ModificaProfiloRistoratore />
            },
            {
                path: '/modificainfoaccount',
                element: <ModificaInfoAccount />
            },
            {
                path: '*',
                element: <NotFound />
            }
        ]
    },
    {
        path: '/',
        element: <ClientLayout />,
        children: [
            /*
            // decommentare qui per dashboard
             {
                path: '/',
                element: <Navigate to="/dashboardcliente" />
             },
            {
                path: '/ristoranti',
                element: <Ristoranti />
            },
            */
        ]
    },
    {
        path: '/',
        element: <RestaurantLayout />,
        children: [
            /*
            // decommentare qui per dashboard
            {
                path: '/',
                element: <Navigate to="/dashboardristoratore" />
            },
            {
                path: '/ristoranti',
                element: <Ristoranti />
            },
            */
        ]
    },
    {
        path: '/',
        element: <GuestLayout />,
        children: [
            {
                path: '/login',
                element: <Login />
            },
            {
                path: '/signup',
                element: <SignUp />
            },
            {
                path: '*',
                element: <NotFound />
            }
        ]
    },
])

export default router;