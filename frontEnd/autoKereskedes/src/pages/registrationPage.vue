<script setup>
import { ref } from 'vue';
import { useController } from '../stores/UIcontrol';
import { useRouter } from 'vue-router';
import Head from '../components/Head.vue';

const router = useRouter();
const msg = ref('');
const successMsg = ref('');
const errors = ref();
const userName = ref('');
const email = ref('');
const password = ref('');
const confirmPassword = ref('');

const regBtn = () => {
  fetch("http://localhost:3300/users/registration", {
    method: "POST",
    headers: {
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      name: userName.value,
      email: email.value,
      password: password.value,
      checkPassword: confirmPassword.value
    })
  }).then(async (res) => {
    const data = await res.json();
    switch(res.status) {
      case 422:
        errors.value = data.errors;
        break;
      case 400:
        msg.value = data.message;
        break;
      case 201:
        successMsg.value = "Sikeres regisztráció!";
        setTimeout(() => {
          router.push('/');
        }, 3500);
        break;
    }
    console.log(data);
  });
};

const store = useController();
</script>

<template>
  <Head />
  
  <div class="registration-page">
    <div class="registration-container">
      <div class="welcome-section">
        <div class="welcome-content">
          <h1 class="welcome-title">
            <i class="ri-car-line"></i>
            Üdvözöljük!
          </h1>
          <p class="welcome-text">
            Csatlakozzon autókereskedésünkhöz és fedezze fel álmai autóját! 
            Regisztrációjával hozzáférést kap exkluzív ajánlatainkhoz és 
            személyre szabott szolgáltatásainkhoz.
          </p>
          <div class="feature-list">
            <div class="feature-item">
              <i class="ri-check-line"></i>
              <span>Kedvenc autók mentése</span>
            </div>
            <div class="feature-item">
              <i class="ri-check-line"></i>
              <span>Tesztvezetés foglalása</span>
            </div>
            <div class="feature-item">
              <i class="ri-check-line"></i>
              <span>Exkluzív ajánlatok</span>
            </div>
            <div class="feature-item">
              <i class="ri-check-line"></i>
              <span>Személyes tanácsadás</span>
            </div>
          </div>
        </div>
      </div>

      <div class="form-section">
        <div class="form-wrapper">
          <form @submit.prevent="regBtn" class="registration-form">
            <div class="form-header">
              <h2 class="form-title">
                <i class="ri-user-add-line"></i>
                Regisztráció
              </h2>
              <p class="form-subtitle">Hozza létre fiókját</p>
            </div>

            <div class="form-group">
              <label class="form-label">
                <i class="ri-user-line"></i>
                Felhasználó név
              </label>
              <div class="input-wrapper">
                <input 
                  v-model="userName" 
                  type="text" 
                  class="form-control"
                  placeholder="Adja meg felhasználó nevét"
                  required
                >
                <i class="ri-user-line input-icon"></i>
              </div>
            </div>

            <div class="form-group">
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
                >
                <i class="ri-mail-line input-icon"></i>
              </div>
            </div>

            <div class="form-group">
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
                >
                <i class="ri-lock-line input-icon"></i>
              </div>
            </div>

            <div class="form-group">
              <label class="form-label">
                <i class="ri-lock-2-line"></i>
                Jelszó megerősítése
              </label>
              <div class="input-wrapper">
                <input 
                  v-model="confirmPassword" 
                  type="password" 
                  class="form-control"
                  placeholder="Erősítse meg jelszavát"
                  required
                >
                <i class="ri-lock-2-line input-icon"></i>
              </div>
            </div>

            <button type="submit" class="submit-btn">
              <i class="ri-user-add-line"></i>
              Regisztráció
            </button>

            <div class="error-section">
              <p v-if="msg" class="error-message">{{ msg }}</p>
                <div v-if="successMsg" class="alert alert-success">
                  <strong>Success!</strong> {{ successMsg }}
                </div>
              <ul v-if="errors && errors.length" class="error-list">
                <li v-for="e in errors" :key="e.msg" class="error-item">{{ e.msg }}</li>
              </ul>
            </div>

            <div class="login-link">
              <p>Már van fiókja? 
                <router-link to="/" class="link">Bejelentkezés</router-link>
              </p>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.registration-page {
  min-height: 100vh;
  background: linear-gradient(135deg, #DDEDE9 0%, #F0FAF6 100%);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem 1rem;
}

.registration-container {
  max-width: 1200px;
  width: 100%;
  background: #fff;
  border-radius: 2rem;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
  overflow: hidden;
  display: grid;
  grid-template-columns: 1fr 1fr;
  min-height: 700px;
}

.welcome-section {
  background: linear-gradient(135deg, #C8BCCF 0%, #A3C9C4 100%);
  padding: 3rem;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}

.welcome-section::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  opacity: 0.3;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='88' height='24' viewBox='0 0 88 24'%3E%3Cg fill-rule='evenodd'%3E%3Cg id='autumn' fill='%23ffffff' fill-opacity='0.28'%3E%3Cpath d='M10 0l30 15 2 1V2.18A10 10 0 0 0 41.76 0H39.7a8 8 0 0 1 .3 2.18v10.58L14.47 0H10zm31.76 24a10 10 0 0 0-5.29-6.76L4 1 2 0v13.82a10 10 0 0 0 5.53 8.94L10 24h4.47l-6.05-3.02A8 8 0 0 1 4 13.82V3.24l31.58 15.78A8 8 0 0 1 39.7 24h2.06zM78 24l2.47-1.24A10 10 0 0 0 86 13.82V0l-2 1-32.47 16.24A10 10 0 0 0 46.24 24h2.06a8 8 0 0 1 4.12-4.98L84 3.24v10.58a8 8 0 0 1-4.42 7.16L73.53 24H78zm0-24L48 15l-2 1V2.18A10 10 0 0 1 46.24 0h2.06a8 8 0 0 0-.3 2.18v10.58L73.53 0H78z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
}

.welcome-content {
  position: relative;
  z-index: 1;
  text-align: center;
  color: #fff;
}

.welcome-title {
  font-size: 3rem;
  font-weight: 700;
  margin-bottom: 1.5rem;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
}

.welcome-title i {
  font-size: 3.5rem;
}

.welcome-text {
  font-size: 1.1rem;
  line-height: 1.6;
  margin-bottom: 2rem;
  opacity: 0.95;
}

.feature-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  text-align: left;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 1rem;
  font-size: 1rem;
  font-weight: 500;
}

.feature-item i {
  background: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  padding: 0.5rem;
  font-size: 1.2rem;
}

.form-section {
  padding: 3rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

.form-wrapper {
  width: 100%;
  max-width: 400px;
}

.registration-form {
  width: 100%;
}

.form-header {
  text-align: center;
  margin-bottom: 2rem;
}

.form-title {
  color: #536066;
  font-size: 2.2rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.form-title i {
  color: #A3C9C4;
  font-size: 2.5rem;
}

.form-subtitle {
  color: #999;
  font-size: 1rem;
  margin: 0;
}

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

.submit-btn {
  width: 100%;
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
  margin-bottom: 1.5rem;
}

.submit-btn:hover {
  background: linear-gradient(135deg, #92b8b3 0%, #7da8a3 100%);
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(163, 201, 196, 0.4);
}

.submit-btn:active {
  transform: translateY(0);
}

.error-section {
  margin-bottom: 1.5rem;
  max-height: 150px;
  overflow-y: auto;
}

.error-message {
  background-color: rgba(220, 53, 69, 0.1);
  color: #dc3545;
  padding: 0.8rem 1rem;
  border-radius: 0.5rem;
  border-left: 4px solid #dc3545;
  margin: 0.8rem 0;
  font-weight: 500;
  font-size: 0.95rem;
  box-shadow: 0 2px 8px rgba(220, 53, 69, 0.15);
}

.error-list {
  list-style: none;
  padding: 0;
  margin: 0.8rem 0;
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.error-item {
  background-color: rgba(220, 53, 69, 0.1);
  color: #dc3545;
  padding: 0.5rem 0.8rem;
  border-radius: 0.4rem;
  border-left: 3px solid #dc3545;
  font-size: 0.85rem;
  font-weight: 500;
  box-shadow: 0 1px 4px rgba(220, 53, 69, 0.1);
  flex: 1 1 100%;
  text-align: center;
}

.error-item:before {
  content: "⚠";
  margin-right: 0.5rem;
  font-weight: bold;
}

.login-link {
  text-align: center;
}

.login-link p {
  color: #666;
  margin: 0;
}

.link {
  color: #A3C9C4;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease;
}

.link:hover {
  color: #92b8b3;
  text-decoration: underline;
}

@media (max-width: 968px) {
  .registration-container {
    grid-template-columns: 1fr;
    max-width: 500px;
  }
  
  .welcome-section {
    padding: 2rem;
    min-height: 300px;
  }
  
  .welcome-title {
    font-size: 2.2rem;
  }
  
  .welcome-title i {
    font-size: 2.5rem;
  }
  
  .form-section {
    padding: 2rem;
  }
}

@media (max-width: 576px) {
  .registration-page {
    padding: 1rem;
  }
  
  .welcome-section {
    padding: 1.5rem;
  }
  
  .form-section {
    padding: 1.5rem;
  }
  
  .welcome-title {
    font-size: 1.8rem;
  }
  
  .form-title {
    font-size: 1.8rem;
  }
  
  .form-title i {
    font-size: 2rem;
  }
}
</style>