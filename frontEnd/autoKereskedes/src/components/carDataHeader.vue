<script setup>
const props = defineProps({
  car: {
    type: Object,
    required: true
  }
});
</script>

<template>
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
    
    <div class="car-title-section">
      <h1 class="car-title">{{ car.model }}</h1>
      <div class="car-price">{{ car.ar }} HUF</div>
    </div>
  </div>
</template>

<style scoped>
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

@media (max-width: 768px) {
  .car-title {
    font-size: 2rem;
  }
  
  .car-price {
    font-size: 1.5rem;
  }
}
</style>