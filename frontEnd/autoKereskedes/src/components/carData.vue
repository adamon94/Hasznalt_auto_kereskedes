<script setup>
import { ref } from 'vue';

const props = defineProps({
  car: {
    type: Object,
    required: true
  }
});

const activeTab = ref('basic');

const tabs = [
  { id: 'basic', label: 'Alapadatok', icon: 'ri-car-line' },
  { id: 'technical', label: 'Műszaki adatok', icon: 'ri-settings-3-line' },
  { id: 'history', label: 'Előzmények', icon: 'ri-history-line' }
];

const setActiveTab = (tabId) => {
  activeTab.value = tabId;
};
</script>

<template>
  <div class="car-data-container">
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
  </div>
</template>

<style scoped>
.car-data-container {
  width: 100%;
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

/* Responsive Design */
@media (max-width: 768px) {
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
}
</style>