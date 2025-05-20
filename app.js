const express = require('express');
const app = express();
const port = 3000;

// Middleware pour parser le JSON et les données de formulaire
app.use(express.json()); // pour parser application/json
app.use(express.urlencoded({ extended: true })); // pour parser application/x-www-form-urlencoded

// Données des personnes âgées (auto-correction: const déplacée en dehors des routes pour être réutilisables)
const elders = [
    { id: 1, name: 'Franco', age: 95 },
    { id: 2, name: 'Soares', age: 84 },
    { id: 3, name: 'Tim', age: 80 },
    { id: 4, name: 'Shimo', age: 94 },
    { id: 5, name: 'Zanon', age: 86 },
    { id: 6, name: 'Matveev', age: 77 },
    { id: 7, name: 'Mahe', age: 93 },
    { id: 8, name: 'Samir', age: 82 }  
];

// Route GET pour obtenir la liste complète des personnes âgées
app.get('/elders', (req, res) => {
    res.json(elders);
});

// Route GET pour obtenir une personne âgée par son nom
app.get('/elders/:name', (req, res) => {
    // Récupère le nom depuis les paramètres de la requête
    const name = req.params.name;
    
    // Recherche la personne âgée correspondante
    const elder = elders.find(e => e.name.toLowerCase() === name.toLowerCase());
    
    // Si une personne âgée est trouvée, renvoie ses informations en JSON
    if (elder) {
        res.json(elder);
    } else {
        // Sinon, renvoie une erreur 404 avec un message
        res.status(404).json({ error: 'Elder not found' });
    }
});

// Route POST pour ajouter une nouvelle personne âgée
app.post('/elders', (req, res) => {
    // Récupère les données du corps de la requête
    const { name, age } = req.body;
    
    // Validation des données
    if (!name || !age) {
        return res.status(400).json({ error: 'Name and age are required' });
    }
    
    if (typeof name !== 'string' || name.trim() === '') {
        return res.status(400).json({ error: 'Name must be a non-empty string' });
    }
    
    if (isNaN(parseInt(age)) || parseInt(age) < 0) {
        return res.status(400).json({ error: 'Age must be a positive number' });
    }
    
    // Vérifie si une personne avec ce nom existe déjà
    const existingElder = elders.find(e => e.name.toLowerCase() === name.toLowerCase());
    if (existingElder) {
        return res.status(409).json({ error: 'A person with this name already exists' });
    }
    
    // Génère un nouvel ID (le plus grand ID actuel + 1)
    const newId = Math.max(...elders.map(e => e.id)) + 1;
    
    // Crée un nouvel objet avec les données fournies
    const newElder = {
        id: newId,
        name: name,
        age: parseInt(age)
    };
    
    // Ajoute le nouvel objet au tableau
    elders.push(newElder);
    
    // Renvoie le nouvel objet créé avec un statut 201 (Created)
    res.status(201).json(newElder);
});

// Démarrage du serveur
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});



