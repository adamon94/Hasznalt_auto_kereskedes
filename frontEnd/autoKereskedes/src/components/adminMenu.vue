<script setup>
import { Button } from 'bootstrap';
import { onMounted, ref } from 'vue';
import { RouterLink } from 'vue-router';
import manageCard from './manageCard.vue';
import testCard from './testCard.vue';
import adminTestCard from './adminTestCard.vue';
import AdminDialog from './adminDialog.vue';

const currentTab = ref('addCar'); // Default active tab

// Function to handle tab switching
const setActiveTab = (tabName) => {
    currentTab.value = tabName;
    console.log('Current tab:', tabName);
};
const isDialogOpen = ref(false);

const closeDialog = () => {
    isDialogOpen.value = false;
    successMessage.value = '';
    errorMessage.value = '';
};

// State for all cars
const allCars = ref([]);
const allFavs = ref([]);
const selectedCar = ref(null);

const setSelectedCar = (carId) => {
    selectedCar.value = allCars.value.find(car => car.id === carId);
    currentTab.value = 'updateCar';
    console.log('Selected car for update:', selectedCar.value);
};
// Fetch all cars from database
const fetchAllCars = async () => {
    try {
        const response = await fetch('http://localhost:3300/cars/getCars');
        const data = await response.json();
        // Transform data to match testCard expected structure
        allCars.value = data;
        console.log('Fetched cars:', allCars.value);
    } catch (error) {
        console.error('Error fetching cars:', error);
    }
};

// Fetch all favorites to calculate like counts
const getAllFavs = async () => {
    try {
        const response = await fetch('http://localhost:3300/cars/allFavs');
        const data = await response.json();
        allFavs.value = data;
    } catch (error) {
        console.error('Error fetching favorites:', error);
    }
};

// Count likes for a specific car
const countLikes = (carId) => {
    let count = 0;
    allFavs.value.forEach(fav => {
        if (fav.autoId === carId) {
            count++;
        }
    });
    return count;
};

// State for all test drives
const allTestDrives = ref([]);

// Fetch all test drives
const fetchAllTestDrives = async () => {
    try {
        const response = await fetch('http://localhost:3300/administration/getAllTestDrives');
        const data = await response.json();
        allTestDrives.value = data;
        console.log('Fetched test drives:', allTestDrives.value);
    } catch (error) {
        console.error('Error fetching test drives:', error);
    }
};

// Form data
const carForm = ref({
    gyartasEve: '',
    model: '',
    marka: '',
    tipus: '',
    ar: '',
    tomeg: '',
    meghajtas: '',
    hengerUrTartalom: '',
    sebessegValtoRendszer: '',
    ferohely: '',
    uzemAnyagTipus: '',
    fogyasztas: '',
    megtettKm: '',
    tulajdonosokSzama: '',
    serulesek: '',
    utolsoMuszakiVizsga: '',
    felujitasok: ''
});

// Image upload state
const selectedImages = ref([]);
const imagePreviews = ref([]);

// Update form image state
const updateSelectedImages = ref([]);
const updateImagePreviews = ref([]);

// Handle file upload for new car
const handleImageUpload = (event) => {
    const files = Array.from(event.target.files);
    
    files.forEach(file => {
        // Validate file type
        if (!file.type.startsWith('image/')) {
           message.value = `${file.name} nem kép fájl!`;
           isDialogOpen.value = true;
            return;
        }
        
        // Validate file size (5MB max)
        if (file.size > 5 * 1024 * 1024) {
            message.value = `${file.name} túl nagy! Maximum 5MB engedélyezett.`;
            isDialogOpen.value = true;
            return;
        }
        
        // Add file to selected images
        selectedImages.value.push(file);
        
        // Create preview
        const reader = new FileReader();
        reader.onload = (e) => {
            imagePreviews.value.push({
                url: e.target.result,
                name: file.name
            });
        };
        reader.readAsDataURL(file);
    });
    
    console.log('Selected images:', selectedImages.value);
};

// Remove image from preview (new car)
const removeImage = (index) => {
    selectedImages.value.splice(index, 1);
    imagePreviews.value.splice(index, 1);
};

// Handle file upload for updating car
const handleUpdateImageUpload = (event) => {
    const files = Array.from(event.target.files);
    
    files.forEach(file => {
        // Validate file type
        if (!file.type.startsWith('image/')) {
            alert(`${file.name} nem kép fájl!`);
            return;
        }
        
        // Validate file size (5MB max)
        if (file.size > 5 * 1024 * 1024) {
            alert(`${file.name} túl nagy! Maximum 5MB engedélyezett.`);
            return;
        }
        
        // Add file to update images
        updateSelectedImages.value.push(file);
        
        // Create preview
        const reader = new FileReader();
        reader.onload = (e) => {
            updateImagePreviews.value.push({
                url: e.target.result,
                name: file.name
            });
        };
        reader.readAsDataURL(file);
    });
    
    console.log('Update images:', updateSelectedImages.value);
};

// Remove new image from update preview
const removeUpdateImage = (index) => {
    updateSelectedImages.value.splice(index, 1);
    updateImagePreviews.value.splice(index, 1);
};

// Delete existing car image
const deleteCarImage = async (imageId) => {
    if (!confirm('Biztosan törölni szeretné ezt a képet?')) {
        return;
    }
    console.log('Deleting image for image_ID:', imageId);
    
    try {
        const response = await fetch(`http://localhost:3300/administration/delImage/${imageId}`, {
            method: 'DELETE'
        });
        
        if (response.ok) {
            // Remove image from selectedCar.Images array
            const imageIndex = selectedCar.value.Images.findIndex(img => img.image_id === imageId);
            if (imageIndex > -1) {
                selectedCar.value.Images.splice(imageIndex, 1);
            }
            message.value = 'Kép sikeresen törölve!';
            isDialogOpen.value = true;
        } else {
            message.value = 'Hiba történt a kép törlése során.';
            isDialogOpen.value = true;
        }
    } catch (error) {
        console.error('Error deleting image:', error);
        message.value = 'Szerver hiba történt a kép törlése során.';
        isDialogOpen.value = true;
    }
};


const uploadImage = async (id) => {
    if (selectedImages.value.length === 0) {
        message.value = 'Nincs kiválasztott kép a feltöltéshez!';
        return;
    }
    
    try {
        const formData = new FormData();
        
        // Add all selected images to FormData
        selectedImages.value.forEach((file) => {
            formData.append('files', file);
        });
        
        const response = await fetch(`http://localhost:3300/administration/addImages/${id}`, {
            method: 'POST',
            body: formData
        });
        
        if (response.ok) {
            //const result = await response.json();
            selectedImages.value = [];
            imagePreviews.value = [];
        } else {
            const error = await response.json();
            message.value = `Hiba történt a képek feltöltése során: ${error.message || 'Ismeretlen hiba'}`;
            isDialogOpen.value = true;
        }
    } catch (error) {
        console.error('Error uploading images:', error);
        message.value = 'Szerver hiba történt a képek feltöltése során.';
        isDialogOpen.value = true;
    }
};
// Upload new images to existing car
const uploadNewImages = async () => {
    if (updateSelectedImages.value.length === 0) {
        message.value = 'Nincs kiválasztott kép a feltöltéshez!';
        isDialogOpen.value = true;
        return;
    }
    
    /*if (!selectedCar.value || !selectedCar.value.id) {
        alert('Nincs kiválasztott autó!');
        return;
    }*/
    
    try {
        const formData = new FormData();
        
        // Add all selected images to FormData
        updateSelectedImages.value.forEach((file) => {
            formData.append('files', file);
        });
        
        /* Add car ID
        formData.append('carId', selectedCar.value.id);*/
        console.log('Uploading images for car ID:', selectedCar.value.id);
        const response = await fetch(`http://localhost:3300/administration/addImages/${selectedCar.value.id}`, {
            method: 'POST',
            body: formData
        });
        
        if (response.ok) {
            const result = await response.json();
            message.value = `Sikeresen feltöltve ${updateSelectedImages.value.length} kép!`;
            isDialogOpen.value = true;

            // Clear previews and selected images
            updateSelectedImages.value = [];
            updateImagePreviews.value = [];
            
            // Refresh the selected car data to show new images
            const carResponse = await fetch(`http://localhost:3300/cars/getCar/${selectedCar.value.id}`);
            if (carResponse.ok) {
                const updatedCar = await carResponse.json();
                selectedCar.value = updatedCar;
            }
            
            // Refresh all cars list
            await fetchAllCars();
        } else {
            const error = await response.json();
            message.value = `Hiba történt a képek feltöltése során: ${error.message || 'Ismeretlen hiba'}`;
            isDialogOpen.value = true;
        }
    } catch (error) {
        console.error('Error uploading images:', error);
        message.value = 'Szerver hiba történt a képek feltöltése során.';
        isDialogOpen.value = true;
    }
};

const message = ref('');


// Submit update car form function
const submitUpdateCarForm = async () => {
    try {
        const response = await fetch(`http://localhost:3300/administration/updateCar/${selectedCar.value.id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(selectedCar.value)
        });

        if (response.ok) {
            message.value = `Autó sikeresen frissítve! Jármű: ${selectedCar.value.model}`;
            isDialogOpen.value = true;
            await fetchAllCars();
        } else {
            message.value = 'Hiba történt az autó frissítése során.';
            isDialogOpen.value = true;
        }
    } catch (error) {
        console.error('Error:', error);
        message.value = 'Szerver hiba történt.';
        isDialogOpen.value = true;
    }
};

// Cancel update and return to manage cars
const cancelUpdate = () => {
    currentTab.value = 'manageCars';
    message.value = '';
};

// Submit form function
const submitCarForm = async () => {
    try {
        if(selectedImages.value.length === 0){
            message.value = 'Kérem válasszon ki legalább egy képet az autóhoz!';
            isDialogOpen.value = true;
            return;
        }
        const response = await fetch('http://localhost:3300/administration/addCar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(carForm.value)
        });

        if (response.ok) {
            const data = await response.json();
             uploadImage(data);
            message.value = `Autó sikeresen hozzáadva! ID: ${data}`;
            isDialogOpen.value = true;
            await fetchAllCars();
            console.log(data);
            // Reset form
            resetForm();
        } else {
            message.value = 'Hiba történt az autó hozzáadása során.';
            isDialogOpen.value = true;
        }
    } catch (error) {
        console.error('Error:', error);
        message.value = 'Szerver hiba történt.';
        isDialogOpen.value = true;
    }
};

const deleteCar = async (carId) => {
    if (!confirm('Biztosan törölni szeretné ezt az autót?')) {
        return;
    }
    console.log('Deleting car with ID:', carId);
    
    try {
        const response = await fetch(`http://localhost:3300/administration/deleteCar/${carId}`, {
            method: 'DELETE'
        });
        
        if (response.ok) {
            message.value = 'Autó sikeresen törölve a kínálatból.';
            setActiveTab('manageCars');
           isDialogOpen.value = true;
            // Refresh car list
            await fetchAllCars();
        } else {
            message.value = 'Hiba történt az autó törlése során.';
            isDialogOpen.value = true;
        }
    } catch (error) {
        console.error('Error deleting car:', error);
        message.value = 'Szerver hiba történt az autó törlése során.';
        isDialogOpen.value = true;
    }
};

const deleteTestDrive = async (testDriveId) => {
    if (!confirm('Biztosan törölni szeretné ezt a tesztvezetést?')) {
        return;
    }
    console.log('Deleting test drive with ID:', testDriveId);
    
    try {
        const response = await fetch(`http://localhost:3300/cars/deleteTest/${testDriveId}`, {
            method: 'DELETE'
        });
        
        if (response.ok) {
            message.value = 'Tesztvezetés sikeresen törölve.';
            isDialogOpen.value = true;
            // Refresh test drives list
            await fetchAllTestDrives();
        } else {
            message.value = 'Hiba történt a tesztvezetés törlése során.';
            isDialogOpen.value = true;
        }
    } catch (error) {
        console.error('Error deleting test drive:', error);
        message.value = 'Szerver hiba történt a tesztvezetés törlése során.';
        isDialogOpen.value = true;
    }
};

// Reset form function
const resetForm = () => {
    carForm.value = {
        gyartasEve: '',
        model: '',
        marka: '',
        tipus: '',
        ar: '',
        tomeg: '',
        meghajtas: '',
        hengerUrTartalom: '',
        sebessegValtoRendszer: '',
        ferohely: '',
        uzemAnyagTipus: '',
        fogyasztas: '',
        megtettKm: '',
        tulajdonosokSzama: '',
        serulesek: '',
        utolsoMuszakiVizsga: '',
        felujitasok: ''
    };
};

// Fetch data on component mount
onMounted(() => {
    fetchAllCars();
    getAllFavs();
    fetchAllTestDrives();
});

/*car object build:
1
: 
{id: 3, gyartasEve: 2003, model: 'Susuki Swift MK3', marka: 'Susuki', tipus: 'Városi autó', …}
2
: 
{id: 4, gyartasEve: 2010, model: 'BMW 2 Series', marka: 'BMW', tipus: 'Sport autó', …}
3
: 
{id: 5, gyartasEve: 2005, model: 'BMW X3', marka: 'BMW', tipus: 'Luxus autó', …}
4
: 
{id: 6, gyartasEve: 2008, model: 'Citroen C4 Picasso', marka: 'Citroen', tipus: 'Luxus autó', …}
5
: 
{id: 7, gyartasEve: 2015, model: 'Citroen c3 Air Cross', marka: 'Citroen', tipus: 'Városi autó', …}
length
: 
6
*/
</script>

<template>

<AdminDialog :isOpen="isDialogOpen" :message="message" :onClose="closeDialog" />


    <div class="adminMenu">

   
<div class="container">
        <aside class="sidebar">
            <div class="logo">
                <i class="fab fa-apple"></i>
            </div>
            <nav class="menu">
                <ul>
                    <li>
                        <button 
                            @click="setActiveTab('addCar')" 
                            :class="['menu-link', { active: currentTab === 'addCar' }]"
                        >
                            <i class="fas fa-plus-circle"></i>
                            <span>Autó felvétele</span>
                        </button>
                    </li>
                    <li>
                        <button 
                            @click="setActiveTab('manageCars')" 
                            :class="['menu-link', { active: currentTab === 'manageCars' }]"
                        >
                            <i class="fas fa-car"></i>
                            <span>Kínálat kezelése</span>
                        </button>
                    </li>
                    <li>
                        <button 
                            @click="setActiveTab('testDrives')" 
                            :class="['menu-link', { active: currentTab === 'testDrives' }]"
                        >
                            <i class="fas fa-calendar-check"></i>
                            <span>Tesztvezetések</span>
                        </button>
                    </li>
                 
                </ul>
            </nav>
         
        </aside>
        <main class="content">
            <!-- Add Car Tab -->
            <div v-if="currentTab === 'addCar'">
                <header>
                    <h1>Autó felvétel</h1>
                    <p>Új autó hozzáadása a kínálathoz</p>
                </header>
                <div class="card-container">
                    <!-- Success/Error Messages
                    <div v-if="successMessage" class="alert alert-success alert-dismissible fade show" role="alert">
                        {{ successMessage }}
                        <button type="button" class="btn-close" @click="successMessage = ''" aria-label="Close"></button>
                    </div>
                    <div v-if="errorMessage" class="alert alert-danger alert-dismissible fade show" role="alert">
                        {{ errorMessage }}
                        <button type="button" class="btn-close" @click="errorMessage = ''" aria-label="Close"></button>
                    </div> -->

                    <form @submit.prevent="submitCarForm">
                        <div class="row">
                            <!-- Gyártási év -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="gyartasEve" class="form-label">Gyártási év</label>
                                    <input type="number" class="form-control" id="gyartasEve" v-model.number="carForm.gyartasEve" required>
                                </div>
                            </div>

                            <!-- Márka -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="marka" class="form-label">Márka</label>
                                    <input type="text" class="form-control" id="marka" v-model="carForm.marka" required>
                                </div>
                            </div>

                            <!-- Modell -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="model" class="form-label">Modell</label>
                                    <input type="text" class="form-control" id="model" v-model="carForm.model" required>
                                </div>
                            </div>

                            <!-- Típus -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="tipus" class="form-label">Típus</label>
                                    <select class="form-select form-control" id="tipus" v-model="carForm.tipus" required>
                                        <option value="">Válasszon típust</option>
                                        <option value="Sedan">Városi autó</option>
                                        <option value="SUV">Luxus autó</option>
                                        <option value="Hatchback">Sport autó</option>
                                        <option value="Kombi">Terepjáró</option>
                                    
                                    </select>
                                </div>
                            </div>

                            <!-- Ár -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="ar" class="form-label">Ár (Ft)</label>
                                    <input type="number" class="form-control" id="ar" v-model.number="carForm.ar" required>
                                </div>
                            </div>

                            <!-- Tömeg -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="tomeg" class="form-label">Tömeg (t)</label>
                                    <input type="decimal" class="form-control" id="tomeg" v-model.number="carForm.tomeg" required>
                                </div>
                            </div>

                            <!-- Meghajtás -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="meghajtas" class="form-label">Meghajtás</label>
                                    <select class="form-select form-control" id="meghajtas" v-model="carForm.meghajtas" required>
                                        <option value="">Válasszon meghajtást</option>
                                        <option value="Első kerék">Első kerék</option>
                                        <option value="Hátsó kerék">Hátsó kerék</option>
                                        <option value="Összkerék">Összkerék</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Hengerűrtartalom -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="hengerUrTartalom" class="form-label">Hengerűrtartalom (cm³)</label>
                                    <input type="number" class="form-control" id="hengerUrTartalom" v-model.number="carForm.hengerUrTartalom" required>
                                </div>
                            </div>

                            <!-- Sebességváltó rendszer -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="sebessegValtoRendszer" class="form-label">Sebességváltó rendszer</label>
                                    <select class="form-select form-control" id="sebessegValtoRendszer" v-model="carForm.sebessegValtoRendszer" required>
                                        <option value="">Válasszon váltót</option>
                                        <option value="Manuális">Manuális</option>
                                        <option value="Automata">Automata</option>
                                        <option value="Félautomata">Félautomata</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Férőhely -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="ferohely" class="form-label">Férőhely (fő)</label>
                                    <input type="number" class="form-control" id="ferohely" v-model.number="carForm.ferohely" required>
                                </div>
                            </div>

                            <!-- Üzemanyag típus -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="uzemAnyagTipus" class="form-label">Üzemanyag típus</label>
                                    <select class="form-select form-control" id="uzemAnyagTipus" v-model="carForm.uzemAnyagTipus" required>
                                        <option value="">Válasszon üzemanyagot</option>
                                        <option value="Benzin">Benzin</option>
                                        <option value="Dízel">Dízel</option>
                                        <option value="Hibrid">Hibrid</option>
                                        <option value="Elektromos">Elektromos</option>
                                        <option value="LPG">LPG</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Fogyasztás -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="fogyasztas" class="form-label">Fogyasztás (L/100km)</label>
                                    <input type="number" step="0.1" class="form-control" id="fogyasztas" v-model.number="carForm.fogyasztas" required>
                                </div>
                            </div>

                            <!-- Megtett km -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="megtettKm" class="form-label">Megtett kilométer</label>
                                    <input type="number" class="form-control" id="megtettKm" v-model.number="carForm.megtettKm" required>
                                </div>
                            </div>

                            <!-- Tulajdonosok száma -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="tulajdonosokSzama" class="form-label">Tulajdonosok száma</label>
                                    <input type="number" class="form-control" id="tulajdonosokSzama" v-model.number="carForm.tulajdonosokSzama" required>
                                </div>
                            </div>

                            <!-- Utolsó műszaki vizsga -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="utolsoMuszakiVizsga" class="form-label">Utolsó műszaki vizsga</label>
                                    <input type="date" class="form-control" id="utolsoMuszakiVizsga" v-model="carForm.utolsoMuszakiVizsga" required>
                                </div>
                            </div>

                            <!-- Sérülések -->
                            <div class="col-md-12 mb-3">
                                <div class="form-group">
                                    <label for="serulesek" class="form-label">Sérülések</label>
                                    <textarea class="form-control" id="serulesek" v-model="carForm.serulesek" rows="3" placeholder="Írja le az esetleges sérüléseket..."></textarea>
                                </div>
                            </div>

                            <!-- Felújítások -->
                            <div class="col-md-12 mb-3">
                                <div class="form-group">
                                    <label for="felujitasok" class="form-label">Felújítások</label>
                                    <textarea class="form-control" id="felujitasok" v-model="carForm.felujitasok" rows="3" placeholder="Írja le az elvégzett felújításokat..."></textarea>
                                </div>
                            </div>

                            <!-- Car Images Upload -->
                            <div class="col-md-12 mb-3">
                                <div class="form-group">
                                    <label for="carImages" class="form-label">
                                        <i class="fas fa-images me-2"></i>Autó képek feltöltése
                                    </label>
                                    <div class="upload-area">
                                        <input 
                                            type="file" 
                                            class="form-control" 
                                            id="carImages" 
                                            accept="image/*" 
                                            multiple
                                            @change="handleImageUpload"
                                        >
                                        <div class="upload-instructions">
                                            <i class="fas fa-cloud-upload-alt upload-icon"></i>
                                            <p class="mb-1"><strong>Kattintson vagy húzza ide a képeket</strong></p>
                                            <p class="text-muted small">PNG, JPG, JPEG vagy WEBP (Max. 5MB / kép)</p>
                                            <p class="text-muted small">Több kép is feltölthető egyszerre</p>
                                        </div>
                                    </div>
                                    
                                    <!-- Image Preview Area -->
                                    <div class="image-preview-container mt-3">
                                        <div class="image-preview-grid">
                                            <!-- Show placeholder if no images -->
                                            <div v-if="imagePreviews.length === 0" class="preview-placeholder">
                                                <i class="fas fa-image"></i>
                                                <span>Képek előnézete itt jelenik meg</span>
                                            </div>
                                            
                                            <!-- Show image previews -->
                                            <div 
                                                v-for="(preview, index) in imagePreviews" 
                                                :key="index" 
                                                class="preview-item"
                                            >
                                                <img :src="preview.url" :alt="preview.name">
                                                <button 
                                                    type="button" 
                                                    class="remove-btn" 
                                                    @click="removeImage(index)"
                                                    title="Kép törlése"
                                                >
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <!-- Submit and Reset Buttons -->
                        <div class="d-flex gap-2 mt-3">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-plus-circle me-2"></i>Autó hozzáadása
                            </button>
                            <button type="button" class="btn btn-secondary" @click="resetForm">
                                <i class="fas fa-redo me-2"></i>Űrlap törlése
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Manage Cars Tab -->
            <div v-if="currentTab === 'manageCars'">
                <header>
                    <h1>Kínálat kezelése</h1>
                    <p>Autók szerkesztése és törlése</p>
                </header>
                <div class="card-container">
                    <!-- Loading State -->
                    <div v-if="allCars.length === 0" class="loading-message">
                        <i class="ri-loader-4-line loading-icon"></i>
                        <p>Autók betöltése...</p>
                    </div>

                    <!-- Cars Grid -->
                    <div v-else class="cars-grid">
                        <manageCard
                            v-for="car in allCars" 
                            :key="car.id"
                            :car="car"
                            :likes="countLikes(car.id)"
                            @sendCarId="setSelectedCar"
                            
                        />
                    </div>
                </div>
            </div>

            <!-- Test Drives Tab -->
            <div v-if="currentTab === 'testDrives'">
                <header>
                    <h1>Tesztvezetések</h1>
                    <p>Tesztvezetési foglalások kezelése</p>
                </header>
                <div class="card-container">
                    <!-- Loading State -->
                    <div v-if="allTestDrives.length === 0" class="loading-state">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Betöltés...</span>
                        </div>
                        <p>Tesztvezetések betöltése...</p>
                    </div>

                    <!-- Test Drives Grid -->
                    <div v-else class="cars-grid">
                        <div v-for="testDrive in allTestDrives" :key="testDrive.id" class="test-drive-card-wrapper">
                            <adminTestCard
                                :car="testDrive"
                                :likes="countLikes(testDrive.autoId)"
                                :testDriveId="testDrive.id"
                                :removeTestDrive="deleteTestDrive"
                            />
                            <div class="test-drive-info">
                                <div class="badge bg-primary">
                                    <i class="ri-calendar-line me-1"></i>
                                    {{ new Date(testDrive.datum).toLocaleDateString('hu-HU') }}
                                </div>
                                <div class="badge bg-success">
                                    <i class="ri-user-line me-1"></i>
                                    {{ testDrive.Users.name }}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div v-if="currentTab === 'updateCar'">
                <header>
                    <h1>Autó frissítése</h1>
                    <p>Autó adatainak módosítása</p>
                </header>
                <div class="card-container">
                   

                    <!-- Update Car Form -->
                    <form v-if="selectedCar" @submit.prevent="submitUpdateCarForm">
                        <div class="row">
                            <!-- Gyártási év -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_gyartasEve" class="form-label">Gyártási év</label>
                                    <input type="number" class="form-control" id="update_gyartasEve" v-model.number="selectedCar.gyartasEve" required>
                                </div>
                            </div>

                            <!-- Márka -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_marka" class="form-label">Márka</label>
                                    <input type="text" class="form-control" id="update_marka" v-model="selectedCar.marka" required>
                                </div>
                            </div>

                            <!-- Modell -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_model" class="form-label">Modell</label>
                                    <input type="text" class="form-control" id="update_model" v-model="selectedCar.model" required>
                                </div>
                            </div>

                            <!-- Típus -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_tipus" class="form-label">Típus</label>
                                    <select class="form-select form-control" id="update_tipus"  v-model="selectedCar.tipus" required>
                                        <option value="">Válasszon típust</option>
                                        <option value="Sedan">Városi autó</option>
                                        <option value="SUV">Luxus autó</option>
                                        <option value="Hatchback">Sport autó</option>
                                        <option value="Kombi">Terepjáró</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Ár -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_ar" class="form-label">Ár (Ft)</label>
                                    <input type="number" class="form-control" id="update_ar" v-model.number="selectedCar.ar" required>
                                </div>
                            </div>

                            <!-- Tömeg -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_tomeg" class="form-label">Tömeg (t)</label>
                                    <input type="decimal" class="form-control" id="update_tomeg" v-model.number="selectedCar.tomeg" required>
                                </div>
                            </div>

                            <!-- Meghajtás -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_meghajtas" class="form-label">Meghajtás</label>
                                    <select class="form-select form-control" id="update_meghajtas" v-model="selectedCar.meghajtas" required>
                                        <option value="">Válasszon meghajtást</option>
                                        <option value="Első kerék">Első kerék</option>
                                        <option value="Hátsó kerék">Hátsó kerék</option>
                                        <option value="Összkerék">Összkerék</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Hengerűrtartalom -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_hengerUrTartalom" class="form-label">Hengerűrtartalom (cm³)</label>
                                    <input type="number" class="form-control" id="update_hengerUrTartalom" v-model.number="selectedCar.hengerUrTartalom" required>
                                </div>
                            </div>

                            <!-- Sebességváltó rendszer -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_sebessegValtoRendszer" class="form-label">Sebességváltó rendszer</label>
                                    <select class="form-select form-control" id="update_sebessegValtoRendszer" v-model="selectedCar.sebessegValtoRendszer" required>
                                        <option value="">Válasszon váltót</option>
                                        <option value="Manuális">Manuális</option>
                                        <option value="Automata">Automata</option>
                                        <option value="Félautomata">Félautomata</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Férőhely -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_ferohely" class="form-label">Férőhely (fő)</label>
                                    <input type="number" class="form-control" id="update_ferohely" v-model.number="selectedCar.ferohely" required>
                                </div>
                            </div>

                            <!-- Üzemanyag típus -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_uzemAnyagTipus" class="form-label">Üzemanyag típus</label>
                                    <select class="form-select form-control" id="update_uzemAnyagTipus" v-model="selectedCar.uzemAnyagTipus" required>
                                        <option value="">Válasszon üzemanyagot</option>
                                        <option value="Benzin">Benzin</option>
                                        <option value="Dízel">Dízel</option>
                                        <option value="Hibrid">Hibrid</option>
                                        <option value="Elektromos">Elektromos</option>
                                        <option value="LPG">LPG</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Fogyasztás -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_fogyasztas" class="form-label">Fogyasztás (L/100km)</label>
                                    <input type="number" step="0.1" class="form-control" id="update_fogyasztas" v-model.number="selectedCar.fogyasztas" required>
                                </div>
                            </div>

                            <!-- Megtett km -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_megtettKm" class="form-label">Megtett kilométer</label>
                                    <input type="number" class="form-control" id="update_megtettKm" v-model.number="selectedCar.megtettKm" required>
                                </div>
                            </div>

                            <!-- Tulajdonosok száma -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_tulajdonosokSzama" class="form-label">Tulajdonosok száma</label>
                                    <input type="number" class="form-control" id="update_tulajdonosokSzama" v-model.number="selectedCar.tulajdonosokSzama" required>
                                </div>
                            </div>

                            <!-- Utolsó műszaki vizsga -->
                            <div class="col-md-6 mb-3">
                                <div class="form-group">
                                    <label for="update_utolsoMuszakiVizsga" class="form-label">Utolsó műszaki vizsga</label>
                                    <input type="date" class="form-control" id="update_utolsoMuszakiVizsga" 
                                        :value="selectedCar.utolsoMuszakiVizsga ? selectedCar.utolsoMuszakiVizsga.substring(0, 10) : ''" 
                                        @input="selectedCar.utolsoMuszakiVizsga = $event.target.value" required>
                                </div>
                            </div>

                            <!-- Sérülések -->
                            <div class="col-md-12 mb-3">
                                <div class="form-group">
                                    <label for="update_serulesek" class="form-label">Sérülések</label>
                                    <textarea class="form-control" id="update_serulesek" v-model="selectedCar.serulesek" rows="3" placeholder="Írja le az esetleges sérüléseket..."></textarea>
                                </div>
                            </div>

                            <!-- Felújítások -->
                            <div class="col-md-12 mb-3">
                                <div class="form-group">
                                    <label for="update_felujitasok" class="form-label">Felújítások</label>
                                    <textarea class="form-control" id="update_felujitasok" v-model="selectedCar.felujitasok" rows="3" placeholder="Írja le az elvégzett felújításokat..."></textarea>
                                </div>
                            </div>
                        </div>

                        <!-- Submit and Cancel Buttons -->
                        <div class="d-flex gap-2 mt-3 mb-4">
                            <button type="submit" class="btn btn-success mngBtn">
                                Módosítások mentése
                            </button>
                            <button type="button" @click="deleteCar(selectedCar.id)" class="btn btn-danger mngBtn">
                               Levétel a kínálatból
                            </button>
                            <button type="button" class="btn btn-secondary mngBtn" @click="cancelUpdate">
                                Vissza a kínálat kezeléséhez
                            </button>
                        </div>

                        <!-- Existing Car Images Management -->
                        <div class="image-management-section">
                            <h5 class="text-white mb-3">
                                <i class="fas fa-images me-2"></i>Autó képek kezelése
                            </h5>
                            
                            <!-- Existing Images -->
                            <div class="existing-images-section mb-3">
                                <h6 class="text-white mb-2">Jelenlegi képek:</h6>
                                <div class="image-preview-grid">
                                    <template v-if="selectedCar.Images && selectedCar.Images.length > 0">
                                        <div 
                                            v-for="(image, index) in selectedCar.Images" 
                                            :key="image.id" 
                                            class="preview-item existing-image"
                                        >
                                            <img :src="'http://localhost:3300/images/' + image.path" :alt="'Car image ' + (index + 1)">
                                            <button 
                                                type="button" 
                                                class="remove-btn" 
                                                @click="deleteCarImage(image.image_id)"
                                                title="Kép törlése"
                                            >
                                                <i class="fas fa-trash"></i>
                                            </button>
                                    
                                        </div>
                                    </template>
                                    
                                    <!-- No images placeholder -->
                                    <div v-else class="preview-placeholder">
                                        <i class="fas fa-image"></i>
                                        <span>Nincs feltöltött kép</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Add New Images -->
                            <div class="add-images-section">
                                <h6 class="text-white mb-2">Új képek hozzáadása:</h6>
                                <div class="upload-area">
                                    <input 
                                        type="file" 
                                        class="form-control" 
                                        id="updateCarImages" 
                                        accept="image/*" 
                                        multiple
                                        @change="handleUpdateImageUpload"
                                    >
                                    <div class="upload-instructions">
                                        <i class="fas fa-cloud-upload-alt upload-icon"></i>
                                        <p class="mb-1"><strong>Kattintson vagy húzza ide az új képeket</strong></p>
                                        <p class="text-muted small">PNG, JPG, JPEG vagy WEBP (Max. 5MB / kép)</p>
                                    </div>
                                </div>
                                
                                <!-- New Images Preview -->
                                <div v-if="updateImagePreviews.length > 0" 
                                    class="image-preview-container mt-3">
                                    <h6 class="text-white mb-2">Új képek előnézet:</h6>
                                    <div class="image-preview-grid">
                                        <div 
                                            v-for="(preview, index) in updateImagePreviews" 
                                            :key="'new-' + index" 
                                            class="preview-item new-image"
                                        >
                                            <img :src="preview.url" :alt="preview.name">
                                            <button 
                                                type="button" 
                                                class="remove-btn" 
                                                @click="removeUpdateImage(index)"
                                                title="Új kép eltávolítása"
                                            >
                                                <i class="fas fa-times"></i>
                                            </button>
                                            <div class="image-info">
                                                <span class="badge bg-success">Új</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Upload New Images Button -->
                                    <div class="upload-images-btn-container mt-3">
                                        <button 
                                            type="button" 
                                            class="btn btn-success upload-images-btn"
                                            @click="uploadNewImages"
                                        >
                                            <i class="fas fa-cloud-upload-alt me-2"></i>
                                            Új képek feltöltése ({{ updateImagePreviews.length }})
                                        </button>
                                        <p class="text-muted small mt-2 mb-0">
                                            <i class="fas fa-info-circle me-1"></i>
                                            Kattintson a gombra a kiválasztott új képek azonnali feltöltéséhez
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- No car selected message -->
                    <div v-else class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Nincs kiválasztott autó. Kérem válasszon egy autót a Kínálat kezelése menüpontból.
                    </div>
                </div>
            </div>
        </main>
    </div>
 </div>
</template>
<style scoped>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary-color: #0066ff;
    --sidebar-width: 280px;
    --sidebar-collapsed-width: 80px;
    --transition-speed: 0.3s;
}
.adminMenu {
   padding: 25px 25px;
    background-color: #DDEDE9;
    
   
}
.container {
    display: flex;
    height: 80vh;
    width: 1600px;
    backdrop-filter: blur(30px);
    -webkit-backdrop-filter: blur(30px);
    border-radius: 24px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.18);
    overflow: hidden;
    margin: 0 auto;
    background-color: #7D8385;
    color: #fff;
}

.sidebar {
    width: var(--sidebar-width);
    height: 100%;
    padding: 30px 15px;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-right: 1px solid rgba(255, 255, 255, 0.08);
    display: flex;
    flex-direction: column;
    transition: width var(--transition-speed) ease;
    position: relative;
}
.logo {
    text-align: center;
    margin-bottom: 40px;
}

.logo i {
    font-size: 36px;
    color: #fff;
    opacity: 0.9;
}

.menu{
    display: flex;
    margin-top: 5rem;
    flex-direction: column;
    justify-content: space-evenly;
}

.menu ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.menu li {
    margin-bottom: 40px;
    border-radius: 16px;
    transition: all 0.2s ease;
    position: relative;
    font-size:larger;
}


.menu li.active {
    background: rgba(255, 255, 255, 0.25);
}





.menu-link {
    display: flex;
    align-items: center;
    gap: 12px;
    color: #fff;
    padding: 14px 18px;
    text-decoration: none;
    font-weight: 500;
    letter-spacing: 0.3px;
    border-radius: 12px;
    transition: all var(--transition-speed) cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
    cursor: pointer;
    pointer-events: auto;
    background-color: transparent;
    border: none;
    width: 100%;
    text-align: left;
}

.menu-link:hover {
    background: rgba(255, 255, 255, 0.15);
    transform: translateX(4px);
}

.menu-link.active {
    background: linear-gradient(135deg, var(--primary-color, rgba(255, 255, 255, 0.25)),rgba(255, 255, 255, 0.25));
    box-shadow: 0 4px 12px;
    transform: translateX(6px);
}

.menu-link i {
    font-size: 18px;
    transition: transform var(--transition-speed);
}

.menu-link:hover i {
    transform: scale(1.1);
}

.menu-link.active i {
    transform: scale(1.15);
}

.form-group input{
    background-color: #F8F5FA;
    width:50%;
}

.form-select {
    background-color: #F8F5FA;
    width:50%;
}

.row{
    margin-left: 5rem;
}

.profile {
    margin-top: auto;
    display: flex;
    align-items: center;
    padding: 16px;
    background: rgba(255, 255, 255, 0.12);
    border-radius: 16px;
    border: 1px solid rgba(255, 255, 255, 0.08);
}

.avatar {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 12px;
    border: 2px solid rgba(255, 255, 255, 0.3);
}

.avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.user-info h3 {
    font-size: 16px;
    font-weight: 500;
    margin-bottom: 2px;
}

.user-info p {
    font-size: 12px;
    opacity: 0.8;
}

.content {
    flex: 1;
    padding: 40px;
    overflow-y: auto;
    
}

header {
    margin-bottom: 30px;
}

header h1 {
    font-size: 32px;
    font-weight: 600;
    margin-bottom: 8px;
}

header p {
    font-size: 16px;
    opacity: 0.8;
}

.card-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 24px;
    margin-top: 30px;
}

.card {
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 24px;
    display: flex;
    align-items: center;
    border: 1px solid rgba(255, 255, 255, 0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    color: #fff;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.card-icon {
    width: 50px;
    height: 50px;
    background: var(--primary-color);
    border-radius: 14px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 16px;
}

.card-icon i {
    font-size: 22px;
}

.card-info h3 {
    font-size: 24px;
    font-weight: 600;
    margin-bottom: 4px;
}

.card-info p {
    font-size: 14px;
    opacity: 0.8;
}

.mngBtn{
    padding: 10px 20px;
}


@media (max-width: 1024px) {
    .sidebar {
        width: var(--sidebar-collapsed-width);
    }
    
    .menu a span, 
    .user-info {
        display: none;
    }
    
    .profile {
        justify-content: center;
    }
    
    .avatar {
        margin-right: 0;
    }
    
    .content {
        padding: 30px;
    }
    
    .card-container {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .container {
        width: 95%;
        height: 90vh;
    }
    
    .card-container {
        grid-template-columns: 1fr;
    }
}

/* Cars Grid Styling */
.cars-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap: 24px;
    padding: 20px 0;
}

/* Test Drive Card Wrapper */
.test-drive-card-wrapper {
    position: relative;
}

.test-drive-info {
    display: flex;
    flex-wrap: wrap;
    gap: 2px;
    /*margin-top: 12px;*/
    margin: 8px 35px 0 0;
    justify-content: center;
}

.test-drive-info .badge {
    display: flex;
    align-items: center;
    font-size: 0.85rem;
    padding: 6px 5px;
    border-radius: 8px;
    font-weight: 500;
    margin-right: 20px;
}

.test-drive-info .badge i {
    font-size: 1rem;
}

/* Loading State */
.loading-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
    color: rgba(255, 255, 255, 0.9);
}

.loading-state p {
    margin-top: 16px;
    font-size: 1.1rem;
    font-weight: 500;
}

.loading-message {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
    color: rgba(255, 255, 255, 0.8);
}

.loading-icon {
    font-size: 48px;
    animation: spin 1s linear infinite;
    margin-bottom: 16px;
}

@keyframes spin {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
}

.loading-message p {
    font-size: 18px;
    font-weight: 500;
}

@media (max-width: 1024px) {
    .cars-grid {
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 20px;
    }
}

@media (max-width: 768px) {
    .cars-grid {
        grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
        gap: 16px;
    }
}

/* Image Upload Styling */
.upload-area {
    position: relative;
    border: 2px dashed rgba(255, 255, 255, 0.3);
    border-radius: 12px;
    padding: 40px 20px;
    background: rgba(255, 255, 255, 0.05);
    transition: all 0.3s ease;
    cursor: pointer;
}

.upload-area:hover {
    border-color: rgba(255, 255, 255, 0.5);
    background: rgba(255, 255, 255, 0.08);
}

.upload-area input[type="file"] {
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    opacity: 0;
    cursor: pointer;
}

.upload-instructions {
    text-align: center;
    color: rgba(255, 255, 255, 0.9);
    pointer-events: none;
}

.upload-icon {
    font-size: 48px;
    color: rgba(255, 255, 255, 0.6);
    margin-bottom: 15px;
    display: block;
}

.upload-instructions p {
    margin: 0;
    color: rgba(255, 255, 255, 0.8);
}

.upload-instructions .text-muted {
    color: rgba(255, 255, 255, 0.5) !important;
    font-size: 13px;
}

/* Image Preview Container */
.image-preview-container {
    margin-top: 20px;
}

.image-preview-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(120px, 1fr));
    gap: 15px;
}

.preview-placeholder {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 30px;
    border: 2px dashed rgba(255, 255, 255, 0.2);
    border-radius: 8px;
    background: rgba(255, 255, 255, 0.03);
    color: rgba(255, 255, 255, 0.5);
    text-align: center;
}

.preview-placeholder i {
    font-size: 36px;
    margin-bottom: 10px;
    opacity: 0.5;
}

.preview-placeholder span {
    font-size: 13px;
    opacity: 0.7;
}

/* Individual preview item styles (for when images are loaded) */
.preview-item {
    position: relative;
    border-radius: 8px;
    overflow: hidden;
    background: rgba(255, 255, 255, 0.1);
    aspect-ratio: 1;
}

.preview-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.preview-item .remove-btn {
    position: absolute;
    top: 5px;
    right: 5px;
    background: rgba(220, 53, 69, 0.9);
    color: white;
    border: none;
    border-radius: 50%;
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s ease;
    opacity: 0;
}

.preview-item:hover .remove-btn {
    opacity: 1;
}

.preview-item .remove-btn:hover {
    background: rgba(220, 53, 69, 1);
    transform: scale(1.1);
}

@media (max-width: 768px) {
    .image-preview-grid {
        grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
        gap: 10px;
    }
    
    .upload-area {
        padding: 30px 15px;
    }
    
    .upload-icon {
        font-size: 36px;
    }
}

/* Image Management Sections */
.image-management-section {
    padding: 25px;
    background: rgba(255, 255, 255, 0.08);
    border-radius: 16px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    margin-top: 20px;
}

.image-management-section h5 {
    font-weight: 600;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid rgba(255, 255, 255, 0.1);
}

.existing-images-section,
.add-images-section {
    padding: 20px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 12px;
    margin-bottom: 15px;
}

.existing-images-section h6,
.add-images-section h6 {
    color: rgba(255, 255, 255, 0.9);
    font-weight: 600;
    margin-bottom: 15px;
}

/* Image Info Badge */
.image-info {
    position: absolute;
    bottom: 5px;
    left: 5px;
}

.image-info .badge {
    font-size: 10px;
    padding: 4px 8px;
    font-weight: 600;
}

/* Existing vs New Image Styling */
.preview-item.existing-image {
    border: 2px solid rgba(108, 117, 125, 0.3);
}

.preview-item.new-image {
    border: 2px solid rgba(25, 135, 84, 0.5);
}

.preview-item.existing-image:hover {
    border-color: rgba(108, 117, 125, 0.6);
}

.preview-item.new-image:hover {
    border-color: rgba(25, 135, 84, 0.8);
}

/* Delete button styling for existing images */
.existing-image .remove-btn {
    background: rgba(220, 53, 69, 0.9);
}

.existing-image .remove-btn i::before {
    content: "\f2ed"; /* trash icon */
}

/* Badge colors */
.badge.bg-secondary {
    background-color: rgba(108, 117, 125, 0.8) !important;
}

.badge.bg-success {
    background-color: rgba(25, 135, 84, 0.8) !important;
}

</style>