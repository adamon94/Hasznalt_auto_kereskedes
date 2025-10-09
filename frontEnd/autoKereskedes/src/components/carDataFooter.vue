<script setup>
const props = defineProps({
  car: {
    type: Object,
    required: true
  },
  allCars: {
    type: Array,
    required: true
  },
  onAddToFavorites: {
    type: Function,
    required: true
  },
  onBookTestDrive: {
    type: Function,
    required: true
  },
  onGoToPrevious: {
    type: Function,
    required: true
  },
  onGoToNext: {
    type: Function,
    required: true
  }
});

const addToFavorites = () => {
  props.onAddToFavorites();
};

const bookTestDrive = () => {
  props.onBookTestDrive();
};

const goToPreviousCar = () => {
  props.onGoToPrevious();
};

const goToNextCar = () => {
  props.onGoToNext();
};
</script>

<template>
  <div class="footer-section">
    <!-- Primary Action Buttons -->
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

    <!-- Navigation Buttons -->
    <div class="navigation-buttons">
      <button class="nav-btn prev-btn" @click="goToPreviousCar" :disabled="allCars.length === 0">
        <i class="ri-arrow-left-line"></i>
        Előző autó
      </button>
      <button class="nav-btn next-btn" @click="goToNextCar" :disabled="allCars.length === 0">
        Következő autó
        <i class="ri-arrow-right-line"></i>
      </button>
    </div>
  </div>
</template>

<style scoped>
/* Footer Section Styles */
.footer-section {
  background-color: #F0FAF6;
  padding: 2rem;
}

.action-buttons {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  margin-bottom: 2rem;
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

/* Navigation Buttons */
.navigation-buttons {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
  padding-top: 1rem;
  border-top: 2px solid #e0e0e0;
}

.nav-btn {
  padding: 1rem 1.5rem;
  border: 2px solid #A3C9C4;
  background-color: #fff;
  color: #536066;
  border-radius: 1rem;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.nav-btn:hover:not(:disabled) {
  background-color: #A3C9C4;
  color: #fff;
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(163, 201, 196, 0.3);
}

.nav-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  background-color: #f5f5f5;
  border-color: #ddd;
  color: #999;
}

.prev-btn i {
  order: -1;
}

.next-btn i {
  order: 1;
}

/* Responsive Design */
@media (max-width: 768px) {
  .action-buttons {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .navigation-buttons {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
  
  .footer-section {
    padding: 1.5rem;
  }
}
</style>