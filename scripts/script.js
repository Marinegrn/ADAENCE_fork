import { elders, placeholderImages } from './dataElders.js';

// Fonction pour afficher les cardes des personnes âgées
function displayElders(filteredElders = elders) {
    const container = document.getElementById('elders-container');
    if (!container) return; // Si le container n'existe pas (page d'accueil), ne rien faire
    
    container.innerHTML = ''; // Vider le conteneur
    
    // Mise à jour du compteur de résultats
    const resultsCount = document.getElementById('results-count');
    if (resultsCount) {
        resultsCount.textContent = `${filteredElders.length} moments trouvés`;
    }
    
    filteredElders.forEach((elder, index) => {
        const card = document.createElement('div');
        card.className = 'card';
        
        const imageUrl = elder.imageUrl || placeholderImages[index % placeholderImages.length];

         // Afficher le chemin dans la console pour déboguer
         //console.log("Chemin d'image utilisé:", imageUrl);
        
        card.innerHTML = `
            <img src="${imageUrl}" alt="${elder.firstname}" class="card-img">
            <div class="card-content">
                <div class="card-type">${elder.type}</div>
                <h3 class="card-name">${elder.firstname}</h3>
                <div class="card-info">${elder.job} • ${elder.age} ans</div>
                <div class="card-info">${elder.city}, ${elder.zipcode}</div>
                <p class="card-desc">${elder.description}</p>
                <button class="card-btn">Programmer un moment</button>
            </div>
        `;
        
        container.appendChild(card);
    });
};

// Fonction de filtrage pour la recherche
function filterElders() {
    const momentTypeElement = document.getElementById('moment-type');
    const locationElement = document.getElementById('location');
    
    if (!momentTypeElement || !locationElement) return;
    
    const typeValue = momentTypeElement.value;
    const locationValue = locationElement.value.toLowerCase();
    
    let filtered = elders;
    
    // Filtrer par type d'activité
    if (typeValue !== 'all') {
        const typeMap = {
            'drink': 'Un café/thé',
            'meal': 'Un repas',
            'conversation': 'Conversation',
            'walk': 'Une promenade',
            'culture': 'Une sortie culturelle',
            'boardGames': 'Jeux de société',
            'other': 'Autre activité'
        };
        
        filtered = filtered.filter(elder => elder.type === typeMap[typeValue]);
    }
    
    // Filtrer par ville
    if (locationValue) {
        filtered = filtered.filter(elder =>
            elder.city.toLowerCase().includes(locationValue) || elder.zipcode.includes(locationValue)
        );
    }
    // Afficher les résultats filtrés
    displayElders(filtered);
};

document.addEventListener('DOMContentLoaded', function() {
    // Charger les filtres au chargement de la page
    loadFiltersFromLocalStorage();

    const searchBtn = document.getElementById('search-button');
        if (searchBtn) {
            searchBtn.addEventListener('click', saveFiltersToLocalStorage);
        }
    // Déterminer sur quelle page nous sommes
    const isPage2 = document.getElementById('elders-container') !== null;
    // Bonus: pagination
    const isPage3 = document.getElementById('elders-container') !== null;
    
    // Page 2 - "Je rends visite"
    if (isPage2 && isPage3) { // bonus pagination
        displayElders();
        
        const searchBtn = document.getElementById('search-button');
        if (searchBtn) {
            searchBtn.addEventListener('click', filterElders);
        }
       
        const resetLink = document.querySelector('.reset-link');
        if (resetLink) {
            resetLink.addEventListener('click', function(e) {
                e.preventDefault();
                const momentTypeElement = document.getElementById('moment-type');
                const locationElement = document.getElementById('location');
                
                if (momentTypeElement) momentTypeElement.value = 'all';
                if (locationElement) locationElement.value = '';
                
                displayElders();
            });
        }
    }
    
    // Page d'accueil
    else {
        // Fonctionnalité de recherche sur la page d'accueil
        const searchBtn = document.querySelector('.search-btn');
        if (searchBtn) {
            searchBtn.addEventListener('click', function() {
                const locationInput = document.getElementById('location');
                const momentSelect = document.getElementById('moment-type');
                
                if (!locationInput || !momentSelect) return;
                
                const location = locationInput.value;
                const momentType = momentSelect.value;
                
                // Gestion d'erreur
                if (location.trim() === '') {
                    alert('Veuillez entrer une localisation');
                    return;
                }
                
                // Animation du bouton
                this.innerHTML = 'Chargement...';
                setTimeout(() => {
                    this.innerHTML = 'Rechercher <i class="fas fa-search"></i>';
                    // Redirection vers la page de résultats
                    window.location.href = './page2.html'; // TODO: ajouter données tapées dans la bar de rechercher par l'utilisateur -> tomber sur les cards concernées
                }, 1000);
            });
        }
    }
});

//Savoir utiliser le LocalStorage
// Charger les filtres depuis le localStorage
function loadFiltersFromLocalStorage() {
    const filters = JSON.parse(localStorage.getItem('filters'));
    if (filters) {
        const momentTypeElement = document.getElementById('moment-type');
        const locationElement = document.getElementById('location');
        
        if (momentTypeElement) momentTypeElement.value = filters.type || 'all';
        if (locationElement) locationElement.value = filters.location || '';
    }
};
// Sauvegarder les filtres dans le localStorage
function saveFiltersToLocalStorage() {
    const momentTypeElement = document.getElementById('moment-type');
    const locationElement = document.getElementById('location');
    
    if (momentTypeElement && locationElement) {
        const filters = {
            type: momentTypeElement.value,
            location: locationElement.value
        };
        localStorage.setItem('filters', JSON.stringify(filters));
    }
};



