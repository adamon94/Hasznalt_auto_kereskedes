<script setup>

const props = defineProps({
  isOpen: {
    type: Boolean,
    required: true
  },
  message: {
    type: String,
    required: false
  },
  onClose: {
    type: Function,
    required: true
  }
});

const closeDialog = () => {
  props.onClose();
};

</script>

<template>
    <!-- Backdrop (átlátszó fekete háttér) -->
    <div v-if="props.isOpen" class="dialog-backdrop" @click="closeDialog">
      <div class="dialog-content" @click.stop>
        <h3>Értesítés!</h3>
        <p>{{ props.message }}</p>
        <button @click="closeDialog">Bezár</button>
      </div>
    </div>
</template>

<style scoped>

/* Backdrop - teljes képernyős átlátszó háttér */
.dialog-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.6);
  backdrop-filter: blur(5px);
  -webkit-backdrop-filter: blur(5px);
  z-index: 99999999;
  display: flex;
  align-items: center;
  justify-content: center;
  animation: fadeInBackdrop 0.3s ease-out;
}

.dialog-content {
  background-color: #DDEDE9;
  padding: 35px 30px;
  border-radius: 20px;
  z-index: 100000000;
  border: 2px solid rgba(100, 149, 237, 0.3);
  width: 400px;
  min-height: 250px;
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 25px;
  
  animation: slideIn 0.3s ease-out;
}

/* H3 stílus */
.dialog-content h3 {
  font-size: 28px;
  font-weight: 700;
  color: #2c3e50;
  margin: 0;
  padding-bottom: 10px;
  border-bottom: 3px solid #C6C1C9;
  width: 100%;
  text-align: center;
  letter-spacing: 0.5px;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}


.dialog-content p {
  font-size: 16px;
  color: #555;
  text-align: center;
  line-height: 1.6;
  margin: 0;
}


.dialog-content button {
  background: #908899;
  color: white;
  border: none;
  padding: 12px 40px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 30px;
  cursor: pointer;
  text-transform: uppercase;
  letter-spacing: 1px;
}


@media (max-width: 768px) {
  .dialog-content {
    width: 90%;
    max-width: 350px;
    padding: 25px 20px;
  }
  
  .dialog-content h3 {
    font-size: 24px;
  }
  
  .dialog-content button {
    padding: 10px 30px;
    font-size: 14px;
  }
}
</style>