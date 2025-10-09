<script setup>
import { onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import Head from '../components/Head.vue';
import CarData from '../components/carData.vue';
import CarDataHeader from '../components/carDataHeader.vue';
import CarDataFooter from '../components/carDataFooter.vue';

const route = useRoute();
const router = useRouter();


const car = ref(null);
const allCars = ref([]);
const currentCarIndex = ref(0);
const carId = route.params.id || 1;

onMounted(() => {
  // Fetch all cars to enable navigation
  fetch("http://localhost:3300/cars/getCars")
    .then(async (res) => {
      const data = await res.json();
      allCars.value = data;
      // Find current car index
      currentCarIndex.value = data.findIndex(c => c.id == carId);
      if (currentCarIndex.value === -1) currentCarIndex.value = 0;
    })
    .catch(error => {
      console.error('Error fetching all cars:', error);
    });

  // Fetch specific car details
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

const addToFavorites = () => {
  // TODO: Implement add to favorites functionality
  console.log('Added to favorites:', car.value?.model);
};

const bookTestDrive = () => {
  // TODO: Implement test drive booking
  console.log('Booking test drive for:', car.value?.model);
};

const goToPreviousCar = () => {
  if (allCars.value.length === 0) return;
  
  const prevIndex = currentCarIndex.value > 0 ? currentCarIndex.value - 1 : allCars.value.length - 1;
  const prevCar = allCars.value[prevIndex];
  
  if (prevCar) {
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
    router.push(`/cars/${nextCar.id}`);
    // Update current data
    currentCarIndex.value = nextIndex;
    car.value = nextCar;
  }
};
</script>

<template>
  <Head />
  
  <div class="car-details-container">
    <div class="car-details-wrapper" v-if="car">
      <!-- Car Images Section -->
      <CarDataHeader :car="car" />

      <!-- Car Data Component with Tabs -->
      <CarData :car="car" />

      <!-- Footer Section with Action Buttons -->
      <CarDataFooter 
        :car="car"
        :allCars="allCars"
        :onAddToFavorites="addToFavorites"
        :onBookTestDrive="bookTestDrive"
        :onGoToPrevious="goToPreviousCar"
        :onGoToNext="goToNextCar"
      />
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