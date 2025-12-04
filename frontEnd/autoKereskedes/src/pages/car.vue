<script setup>
import { onMounted, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import Head from '../components/Head.vue';
import CarData from '../components/carData.vue';
import CarDataHeader from '../components/carDataHeader.vue';
import CarDataFooter from '../components/carDataFooter.vue';
import { useController } from '../stores/UIcontrol.js';
import ReverseTestDriveModal from '../components/reverseTestDriveModal.vue';
import adminDialog from '../components/adminDialog.vue';

const route = useRoute();
const router = useRouter();
const store = useController();


const car = ref(null);
const allCars = ref([]);
const currentCarIndex = ref(0);
const carId = route.params.id || 1;
const currentCarId = ref(carId);


const addFav = async () => {
    try {
      const response = await fetch(`http://localhost:3300/cars/addfav/${store.id}/${currentCarId.value}`, {
        method: 'POST',
      });
      if (response.ok) {
        const data = await response.json();
        console.log('Added to favorites:', data);
        favCheck(currentCarId.value);
      } else {
        console.error('Error adding to favorites:', response.statusText);
      }
    } catch {
      alert('Valószínűleg hálózati hiba történt, próbálja meg később.');
    }
};

const removeFav = async () => {
    try {
      const response = await fetch(`http://localhost:3300/cars/removeFav/${store.id}/${currentCarId.value}`, {
        method: 'DELETE',
      });
      if (response.ok) {
        const data = await response.json();
        console.log('Removed from favorites:', data);
        favCheck(carId);
      } else {
        console.error('Error removing from favorites:', response.statusText);
      }
    } catch (error) {
      console.error('Error removing from favorites:', error);
    }
};

const favCheck = (car) => {
    fetch(`http://localhost:3300/cars/userfav/${store.id}/${car}`, {
      method: 'GET',
    })
      .then(async (res) => {
        const data = await res.json();
        store.isFav = data.isFav;
      })
      .catch(error => {
        console.error('Error fetching favorite status:', error);
      });
  }
;

watch(() => route.params.id, (newId) => {
  if (newId) {
    if(store.isLogged){
      favCheck(newId);
    }
  }
});

watch(() => route.params.id, (newId) => {
  if (newId) {
    currentCarId.value = newId;
    }
  }
);


onMounted(() => {
 
if (store.isLogged){
    favCheck(carId);
}
  fetch("http://localhost:3300/cars/getCars")
    .then(async (res) => {
      const data = await res.json();
      allCars.value = data;
      // Find current car index
      currentCarIndex.value = data.findIndex(c => c.id == carId);
      car.value = data[currentCarIndex.value];
      if (currentCarIndex.value === -1) currentCarIndex.value = 0;
    })
    .catch(error => {
      console.error('Error fetching all cars:', error);
    });
});

const addToFavorites = () => {
  if(store.isLogged){
     addFav();
  }
  else{
    dialogMessage.value = 'A kedvencekhez való hozzáadás előtt kérjük, jelentkezzen be vagy regisztráljon!';
    dialogOpen.value = true;
    return;
  }
 
  console.log('Added to favorites:', car.value?.model);
};

const removeFromFavorites = () => {
  removeFav();
  console.log('Removed from favorites:', car.value?.model);
};

const bookTestDrive = () => {
  // TODO: Implement test drive booking
  console.log('Booking test drive for:', car.value?.model);
  if(store.isLogged){
    store.testDriveModal = true
  }
  else{
    dialogMessage.value = 'A tesztvezetés foglaláshoz kérjük, jelentkezzen be vagy regisztráljon!';
    dialogOpen.value = true;
  }
};

const goToPreviousCar = () => {
  if (allCars.value.length === 0) return;
  
  const prevIndex = currentCarIndex.value > 0 ? currentCarIndex.value - 1 : allCars.value.length - 1;
  const prevCar = allCars.value[prevIndex];
  
  if (prevCar) {
    const element = document.getElementById('scroll-to-header');
  if (element) {
    element.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
    router.push(`/cars/${prevCar.id}`);
    // Update current data
    currentCarIndex.value = prevIndex;
    car.value = prevCar;
  }
};

const goToNextCar = () => {
  if (allCars.value.length === 0) return;
  
  const nextIndex = currentCarIndex.value < allCars.value.length - 1 ? currentCarIndex.value + 1 : 0;
  const nextCar = allCars.value[nextIndex];
  
  if (nextCar) {
//window.scrollTo({ top: 0, behavior: 'smooth' });  
const element = document.getElementById('scroll-to-header');
  if (element) {
    element.scrollIntoView({ 
      behavior: 'smooth',
      block: 'start'
    })
  }
    router.push(`/cars/${nextCar.id}`);
    currentCarIndex.value = nextIndex;
    car.value = nextCar;
  }
};

const dialogOpen = ref(false);
const dialogMessage = ref('');
const closeDialog = () => {
  dialogOpen.value = false;
};
</script>

<template>
  <adminDialog :isOpen="dialogOpen"
                :message="dialogMessage"
                :onClose="closeDialog" />

  <ReverseTestDriveModal :carId="currentCarId"/>
  <div class="car-details-container">
    <div class="car-details-wrapper" v-if="car">
      <!-- Car Images Section -->
      <CarDataHeader id="scroll-to-header" :car="car" />

      <!-- Car Data Component with Tabs -->
      <CarData :car="car" />

      <!-- Footer Section with Action Buttons -->
      <CarDataFooter 
        :car="car"
        :allCars="allCars"
        :onAddToFavorites="addToFavorites"
        :onRemoveFromFavorites="removeFromFavorites"
        :onBookTestDrive="bookTestDrive"
        :onGoToPrevious="goToPreviousCar"
        :onGoToNext="goToNextCar"
      />

      <!-- Képek megjelenítése -->
      

    </div>

    <!-- Loading State -->
    <div v-else class="loading-state">
      <i class="ri-loader-4-line loading-icon"></i>
      <p>Adatok betöltése...</p>
    </div>
  </div>

  <div class="imgSection" v-if="car">
      <div class="car-images">
        <h2>Képek a járműről:</h2>
        <div class="image-container">
          <img v-for="image in car.Images" :key="image.id" :src="'http://localhost:3300/images/' + image.path" :alt="car.model" />
        </div>
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
  padding-bottom: 3rem;
}
.imgSection{
  background-color: #DDEDE9;
  padding-top: 1rem;
  padding-bottom: 3rem;
}
.car-images {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 1rem;
  margin-top: 2rem;
}
.image-container {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
  width: 80%;
  margin-left: 3.2rem;
}
.car-images h2 {
  font-size: 2rem;
  color: #575C5B;
  margin-bottom: 3rem;
}
.car-images img {
  height: 200px;
  width: 300px;
  border-radius: 1rem;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}
.car-details-wrapper {
  max-width: 1100px;
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
}
</style>