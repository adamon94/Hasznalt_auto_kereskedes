<script setup>
import { ref } from 'vue';
import { useController } from '../stores/UIcontrol';

const store = useController();

// Form data
const email = ref('');
const password = ref('');

// Messages
const msg = ref('');
const errors = ref([]);
const isLoading = ref(false);

const logIn = async () => {

  try {
    const response = await fetch("http://localhost:3300/users/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        inputEmail: email.value,
        inputPassword: password.value
      })
    });

    const data = await response.json();

    switch(response.status) {
      case 422:
        errors.value = data.errors || [];
        break;
      case 400:
      case 401:
        msg.value = data.message || 'Hibás bejelentkezési adatok!';
        break;
      case 200:
        msg.value = "Sikeres bejelentkezés!";
        localStorage.setItem("isLogged", true);
        localStorage.setItem("token", JSON.stringify(data.id));
        localStorage.setItem("accessLevel", data.accessLevel);
        store.logIn();
        setTimeout(() => {
          store.closeLog();
          location.reload();
        }, 1500);
        break;
      default:
        msg.value = 'Váratlan hiba történt!';
    }
  } catch (error) {
    msg.value = 'Kapcsolati hiba! Kérem próbálja újra.';
    console.error('Login error:', error);
  } finally {
    isLoading.value = false;
  }
};

const closeModal = () => {
  store.closeLog();
};
</script>


<template>
 
  <div v-if="store.logValue" class="modal-backdrop" @click="closeModal"></div>

  
  <div v-if="store.logValue" class="modal-dialog">
    <div class="modal-content">
      
      <div class="modal-header">
        <h4 class="modal-title">
          <i class="ri-login-circle-line"></i>
          Bejelentkezés
        </h4>
        <button type="button" class="btn-close" @click="closeModal" aria-label="Close">
          <i class="ri-close-line"></i>
        </button>
      </div>

      
      <div class="modal-body">
        <form @submit.prevent="logIn" class="login-form">
          
          <div class="form-group mb-3">
            <label class="form-label">
              <i class="ri-mail-line"></i>
              Email cím
            </label>
            <div class="input-wrapper">
              <input 
                v-model="email" 
                type="email"
                class="form-control"
                placeholder="pelda@email.com"
                required
                :disabled="isLoading"
              >
              <i class="ri-mail-line input-icon"></i>
            </div>
          </div>

         
          <div class="form-group mb-4">
            <label class="form-label">
              <i class="ri-lock-line"></i>
              Jelszó
            </label>
            <div class="input-wrapper">
              <input 
                v-model="password" 
                type="password" 
                class="form-control"
                placeholder="Adja meg jelszavát"
                required
                :disabled="isLoading"
              >
              <i class="ri-lock-line input-icon"></i>
            </div>
          </div>

          
          <button type="submit" class="btn btn-login w-100 mb-3" :disabled="isLoading">
            <span v-if="isLoading" class="spinner-border spinner-border-sm me-2" role="status">
              <span class="visually-hidden">Loading...</span>
            </span>
            <i v-else class="ri-login-circle-line me-2"></i>
            {{ isLoading ? 'Bejelentkezés...' : 'Bejelentkezés' }}
          </button>

          <!-- Success Message -->
          <div v-if="msg && !errors.length" 
               :class="['alert', msg.includes('Sikeres') ? 'alert-success' : 'alert-danger']" 
               role="alert">
            <i :class="msg.includes('Sikeres') ? 'ri-check-circle-line' : 'ri-error-warning-line'"></i>
            {{ msg }}
          </div>

         
          <div v-if="errors.length" class="error-section">
            <div class="alert alert-danger" role="alert">
              <i class="ri-error-warning-line"></i>
              Kérem javítsa a következő hibákat:
            </div>
            <ul class="error-list">
              <li v-for="error in errors" :key="error.msg" class="error-item">
                <i class="ri-close-circle-line"></i>
                {{ error.msg }}
              </li>
            </ul>
          </div>
        </form>
      </div>

     
      <div class="modal-footer">
        <p class="text-muted mb-0">
          Nincs még fiókja? 
          <router-link to="/registration" class="link-primary" @click="closeModal">
            <i class="ri-user-add-line"></i>
            Regisztráció
          </router-link>
        </p>
      </div>
    </div>
  </div>
</template>


<style scoped>

.modal-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.6);
  z-index: 1040;
  backdrop-filter: blur(2px);
}

/* Modal Dialog */
.modal-dialog {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 90%;
  max-width: 450px;
  z-index: 1050;
  animation: modalSlideIn 0.3s ease-out;
}

@keyframes modalSlideIn {
  from {
    opacity: 0;
    transform: translate(-50%, -60%);
  }
  to {
    opacity: 1;
    transform: translate(-50%, -50%);
  }
}

/* Modal Content */
.modal-content {
  background: #fff;
  border-radius: 1rem;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
  overflow: hidden;
  border: none;
}

/* Modal Header */
.modal-header {
  background: linear-gradient(135deg, #A3C9C4 0%, #92b8b3 100%);
  color: #fff;
  padding: 1.5rem 2rem;
  border-bottom: none;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.modal-title {
  font-size: 1.5rem;
  font-weight: 700;
  margin: 0;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.modal-title i {
  font-size: 1.8rem;
}

.btn-close {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  cursor: pointer;
  transition: all 0.3s ease;
}

.btn-close:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: rotate(90deg);
}

.btn-close i {
  font-size: 1.5rem;
}

/* Modal Body */
.modal-body {
  padding: 2rem;
}

.login-form {
  width: 100%;
}

/* Form Groups */
.form-group {
  margin-bottom: 1.5rem;
}

.form-label {
  color: #536066;
  font-weight: 600;
  font-size: 1rem;
  margin-bottom: 0.5rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.form-label i {
  color: #A3C9C4;
  font-size: 1.1rem;
}

/* Input Wrapper */
.input-wrapper {
  position: relative;
}

.form-control {
  width: 100%;
  padding: 1rem 1rem 1rem 3rem;
  border: 2px solid #e0e0e0;
  border-radius: 0.5rem;
  font-size: 1rem;
  background-color: #f8f9fa;
  transition: all 0.3s ease;
}

.form-control:focus {
  outline: none;
  border-color: #A3C9C4;
  background-color: #fff;
  box-shadow: 0 0 0 3px rgba(163, 201, 196, 0.1);
}

.form-control:disabled {
  background-color: #e9ecef;
  opacity: 0.6;
}

.form-control::placeholder {
  color: #999;
  font-style: italic;
}

.input-icon {
  position: absolute;
  left: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: #A3C9C4;
  font-size: 1.2rem;
  pointer-events: none;
}

/* Login Button */
.btn-login {
  background: linear-gradient(135deg, #A3C9C4 0%, #92b8b3 100%);
  color: #fff;
  border: none;
  padding: 1rem 2rem;
  font-size: 1.1rem;
  font-weight: 600;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(163, 201, 196, 0.3);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.btn-login:hover:not(:disabled) {
  background: linear-gradient(135deg, #92b8b3 0%, #7da8a3 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(163, 201, 196, 0.4);
}

.btn-login:active {
  transform: translateY(0);
}

.btn-login:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
}

/* Alert Messages */
.alert {
  border-radius: 0.5rem;
  border: none;
  padding: 1rem;
  margin-bottom: 1rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  font-weight: 500;
}

.alert-success {
  background-color: rgba(25, 135, 84, 0.1);
  color: #198754;
  border-left: 4px solid #198754;
}

.alert-danger {
  background-color: rgba(220, 53, 69, 0.1);
  color: #dc3545;
  border-left: 4px solid #dc3545;
}

.alert i {
  font-size: 1.2rem;
}

/* Error Section */
.error-section {
  max-height: 150px;
  overflow-y: auto;
}

.error-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.error-item {
  background-color: rgba(220, 53, 69, 0.1);
  color: #dc3545;
  padding: 0.8rem;
  border-radius: 0.4rem;
  border-left: 3px solid #dc3545;
  font-size: 0.9rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.error-item i {
  font-size: 1rem;
}

/* Modal Footer */
.modal-footer {
  background-color: #f8f9fa;
  padding: 1.5rem 2rem;
  border-top: 1px solid #e9ecef;
  text-align: center;
}

.modal-footer p {
  margin: 0;
  color: #6c757d;
}

.link-primary {
  color: #A3C9C4;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease;
  display: inline-flex;
  align-items: center;
  gap: 0.3rem;
}

.link-primary:hover {
  color: #92b8b3;
  text-decoration: underline;
}

/* Loading Spinner */
.spinner-border-sm {
  width: 1rem;
  height: 1rem;
  border-width: 0.15em;
}

/* Responsive Design */
@media (max-width: 576px) {
  .modal-dialog {
    width: 95%;
    margin: 1rem auto;
  }
  
  .modal-header {
    padding: 1rem 1.5rem;
  }
  
  .modal-body {
    padding: 1.5rem;
  }
  
  .modal-footer {
    padding: 1rem 1.5rem;
  }
  
  .modal-title {
    font-size: 1.3rem;
  }
  
  .btn-close {
    width: 35px;
    height: 35px;
  }
}
</style>