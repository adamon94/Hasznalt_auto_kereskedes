<script setup>
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';
import Head from '../components/Head.vue';
import { useController } from '../stores/UIcontrol';

const route = useRoute();
const store = useController();

const car = ref(null);
const activeTab = ref('basic');
const carId = route.params.id || 1; // Default to ID 1 if no param

const tabs = [
  { id: 'basic', label: 'Alapadatok', icon: 'ri-car-line' },
  { id: 'technical', label: 'Műszaki adatok', icon: 'ri-settings-3-line' },
  { id: 'history', label: 'Előzmények', icon: 'ri-history-line' }
];

onMounted(() => {
  fetch(`http://localhost:3300/cars/getCar/${carId}`)
    .then(async (res) => {
      const data = await res.json();
      car.value = data;
      console.log('Car details:', car.value);
    })
    .catch(error => {
      console.error('Error fetching car details:', error);
    });
});

const setActiveTab = (tabId) => {
  activeTab.value = tabId;
};

const addToFavorites = () => {
  // TODO: Implement add to favorites functionality
  console.log('Added to favorites:', car.value?.model);
};

const bookTestDrive = () => {
  // TODO: Implement test drive booking
  console.log('Booking test drive for:', car.value?.model);
};
</script>

<template>
  <Head />
  
  <div class="car-details-container">
    <div class="car-details-wrapper" v-if="car">
      <!-- Car Images Section -->
      <div class="car-images-section">
        <div class="main-image">
          <img 
            v-if="car.Images && car.Images[0]" 
            :src="'http://localhost:3300/images/' + car.Images[0].path" 
            :alt="car.model"
          />
          <div v-else class="no-image">
            <i class="ri-image-line"></i>
            <span>Nincs elérhető kép</span>
          </div>
        </div>
        
        <!-- Car Title -->
        <div class="car-title-section">
          <h1 class="car-title">{{ car.model }}</h1>
          <div class="car-price">{{ car.ar }} HUF</div>
        </div>
      </div>

      <!-- Tab Navigation -->
      <div class="tab-navigation">
        <button 
          v-for="tab in tabs" 
          :key="tab.id"
          :class="['tab-button', { active: activeTab === tab.id }]"
          @click="setActiveTab(tab.id)"
        >
          <i :class="tab.icon"></i>
          {{ tab.label }}
        </button>
      </div>

      <!-- Tab Content -->
      <div class="tab-content-wrapper">
        
        <!-- Basic Information Tab -->
        <div v-if="activeTab === 'basic'" class="tab-content">
          <h3 class="tab-title">Alapadatok</h3>
          <div class="info-grid">
            <div class="info-item">
              <span class="info-label">Gyártási év:</span>
              <span class="info-value">{{ car.gyartasEve || 'N/A' }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Márka:</span>
              <span class="info-value">{{ car.marka || 'N/A' }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Modell:</span>
              <span class="info-value">{{ car.model }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Típus:</span>
              <span class="info-value">{{ car.tipus || 'N/A' }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Férőhely:</span>
              <span class="info-value">{{ car.ferohely }} fő</span>
            </div>
          </div>
        </div>

        <!-- Technical Description Tab -->
        <div v-if="activeTab === 'technical'" class="tab-content">
          <h3 class="tab-title">Műszaki adatok</h3>
          <div class="info-grid">
            <div class="info-item">
              <span class="info-label">Hengerűrtartalom:</span>
              <span class="info-value">{{ car.hengerUrTartalom }} cm³</span>
            </div>
            <div class="info-item">
              <span class="info-label">Sebességváltó:</span>
              <span class="info-value">{{ car.sebessegValtoRendszer }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Üzemanyag:</span>
              <span class="info-value">{{ car.uzemAnyagTipus }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Fogyasztás:</span>
              <span class="info-value">{{ car.fogyasztas || 'N/A' }} l/100km</span>
            </div>
            <div class="info-item">
              <span class="info-label">Tömeg:</span>
              <span class="info-value">{{ car.tomeg || 'N/A' }} kg</span>
            </div>
            <div class="info-item">
              <span class="info-label">Meghajtás:</span>
              <span class="info-value">{{ car.meghajtas || 'N/A' }}</span>
            </div>
          </div>
        </div>

        <!-- History Tab -->
        <div v-if="activeTab === 'history'" class="tab-content">
          <h3 class="tab-title">Előzmények</h3>
          <div class="info-grid">
            <div class="info-item">
              <span class="info-label">Futott km:</span>
              <span class="info-value">{{ car.megtettKm?.toLocaleString() || 'N/A' }} km</span>
            </div>
            <div class="info-item">
              <span class="info-label">Előző tulajdonosok:</span>
              <span class="info-value">{{ car.tulajdonosokSzama || 'N/A' }} fő</span>
            </div>
            <div class="info-item">
              <span class="info-label">Sérülések:</span>
              <span class="info-value">{{ car.serulesek || 'Nincs' }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Alkatrész cserék:</span>
              <span class="info-value">{{ car.alkatreszCserek || 'Nincs' }}</span>
            </div>
            <div class="info-item">
              <span class="info-label">Utolsó műszaki:</span>
              <span class="info-value">{{ car.utolsoMuszakiVizsga || 'N/A' }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="action-buttons">
        <button class="action-btn favorite-btn" @click="addToFavorites">
          <i class="ri-heart-line"></i>
          Kedvencekhez adás
        </button>
        <button class="action-btn test-drive-btn" @click="bookTestDrive">
          <i class="ri-car-line"></i>
          Tesztvezetés foglalása
        </button>
      </div>
    </div>

    <!-- Loading State -->
    <div v-else class="loading-state">
      <i class="ri-loader-4-line loading-icon"></i>
      <p>Adatok betöltése...</p>
    </div>
  </div>
</template>

<style scoped>
.car-details-container {
  min-height: 100vh;
  background-color: #DDEDE9;
  padding: 2rem;
  display: flex;
  justify-content: center;
  align-items: flex-start;
}

.car-details-wrapper {
  max-width: 900px;
  width: 100%;
  background-color: #F0FAF6;
  border-radius: 2rem;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15), 0 10px 20px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  transform: translateY(0);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.car-details-wrapper:hover {
  transform: translateY(-5px);
  box-shadow: 0 30px 60px rgba(0, 0, 0, 0.2), 0 15px 30px rgba(0, 0, 0, 0.15);
}

.car-images-section {
  position: relative;
  background: linear-gradient(135deg, #C8BCCF 0%, #A3C9C4 100%);
  padding: 2rem;
}

.main-image {
  width: 100%;
  height: 400px;
  border-radius: 1.5rem;
  overflow: hidden;
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
  background-color: #fff;
  display: flex;
  align-items: center;
  justify-content: center;
}

.main-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.no-image {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #999;
  font-size: 1.2rem;
}

.no-image i {
  font-size: 3rem;
  margin-bottom: 0.5rem;
}

.car-title-section {
  margin-top: 2rem;
  text-align: center;
}

.car-title {
  font-size: 2.5rem;
  font-weight: 700;
  color: #fff;
  margin-bottom: 0.5rem;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

.car-price {
  font-size: 2rem;
  font-weight: 600;
  color: #fff;
  background-color: rgba(255, 255, 255, 0.2);
  padding: 0.5rem 1.5rem;
  border-radius: 2rem;
  display: inline-block;
  backdrop-filter: blur(10px);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.tab-navigation {
  display: flex;
  gap: 0.5rem;
  padding: 0 2rem;
  margin-top: -1rem;
  position: relative;
  z-index: 10;
}

.tab-button {
  background-color: #fff;
  border: none;
  padding: 1rem 1.5rem;
  border-radius: 1rem 1rem 0 0;
  font-weight: 600;
  color: #536066;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 -5px 15px rgba(0, 0, 0, 0.1);
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.tab-button i {
  font-size: 1.2rem;
}

.tab-button:hover {
  background-color: #C8BCCF;
  color: #fff;
  transform: translateY(-2px);
  box-shadow: 0 -8px 20px rgba(0, 0, 0, 0.15);
}

.tab-button.active {
  background-color: #A3C9C4;
  color: #fff;
  transform: translateY(-3px);
  box-shadow: 0 -10px 25px rgba(0, 0, 0, 0.2);
}

.tab-content-wrapper {
  background-color: #fff;
  min-height: 300px;
  box-shadow: inset 0 5px 15px rgba(0, 0, 0, 0.05);
}

.tab-content {
  padding: 2rem;
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(10px); }
  to { opacity: 1; transform: translateY(0); }
}

.tab-title {
  font-size: 1.8rem;
  font-weight: 600;
  color: #536066;
  margin-bottom: 2rem;
  padding-bottom: 0.5rem;
  border-bottom: 3px solid #A3C9C4;
  display: inline-block;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
}

.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background-color: #F8FFFE;
  border-radius: 0.8rem;
  border-left: 4px solid #A3C9C4;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
}

.info-item:hover {
  transform: translateX(5px);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}

.info-label {
  font-weight: 600;
  color: #536066;
  flex: 1;
}

.info-value {
  font-weight: 500;
  color: #2c3e50;
  text-align: right;
  flex: 1;
}

.action-buttons {
  padding: 2rem;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  background-color: #F0FAF6;
}

.action-btn {
  padding: 1.2rem 2rem;
  border: none;
  border-radius: 1rem;
  font-weight: 600;
  font-size: 1.1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.8rem;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.action-btn i {
  font-size: 1.3rem;
}

.favorite-btn {
  background-color: #C8BCCF;
  color: #fff;
}

.favorite-btn:hover {
  background-color: #b8a8c7;
  transform: translateY(-3px);
  box-shadow: 0 12px 30px rgba(200, 188, 207, 0.4);
}

.test-drive-btn {
  background-color: #A3C9C4;
  color: #fff;
}

.test-drive-btn:hover {
  background-color: #92b8b3;
  transform: translateY(-3px);
  box-shadow: 0 12px 30px rgba(163, 201, 196, 0.4);
}

.loading-state {
  text-align: center;
  padding: 4rem;
  background-color: #fff;
  border-radius: 2rem;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.loading-icon {
  font-size: 3rem;
  color: #A3C9C4;
  animation: spin 1s linear infinite;
  margin-bottom: 1rem;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.loading-state p {
  font-size: 1.2rem;
  color: #536066;
  margin: 0;
}

/* Responsive Design */
@media (max-width: 768px) {
  .car-details-container {
    padding: 1rem;
  }
  
  .tab-navigation {
    flex-direction: column;
    gap: 0.2rem;
  }
  
  .tab-button {
    border-radius: 0.5rem;
    width: 100%;
  }
  
  .info-grid {
    grid-template-columns: 1fr;
  }
  
  .action-buttons {
    grid-template-columns: 1fr;
  }
  
  .car-title {
    font-size: 2rem;
  }
  
  .car-price {
    font-size: 1.5rem;
  }
}
</style>