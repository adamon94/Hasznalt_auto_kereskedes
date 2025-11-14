<script setup>
import { ref } from 'vue';
import { useController } from '../stores/UIcontrol.js';

const props = defineProps({
    carId:{
        type:Number,
        required:true
    }
});
const store = useController();
const selectedDate = ref(null);

const message =  ref('');

const addTestDrive = async()=>{
    try{
    const res = await fetch(`http://localhost:3300/cars/test/${store.id}/${props.carId}`,{
        method:'POST',
        headers:{
            'Content-Type':'application/json'
        },
        body:JSON.stringify({
            date: new Date (selectedDate.value).toISOString() // Placeholder date, replace with actual selected date
        })
    });
    const data = await res.json();
    console.log(data);
    if(selectedDate.value ===null){
        return message.value = "Kérem adjon meg egy dátumot"
    }
    switch(res.status){
        case 201:
            message.value = 'Sikeres foglalás, Telefonon fogjuk keresni Önt további eggyeztetés céljából!';
            break;
        case 409:
            message.value = 'Már van egy foglalása erre az autóra!';
            break;
        default:
            message.value = 'Hiba történt a foglalás során.';
    }


    }catch(err){console.error(err)}
    
}

</script>

<template>

<dialog :open="store.testDriveModal">
    <div class="modalContent">
        <!-- Exit button in top-left corner -->
        <button 
            @click="store.testDriveModal = false, selectedDate = null, message = ''"
            class="exit-button"
            type="button"
            title="Bezárás"
        >
            <i class="ri-close-line"></i>
        </button>
        
        <h2>Tesztvezetés kérése</h2>
        <form @submit.prevent>
            <div class="form-group">
                <label class="form-label mb-3" for="testDriveDate">Válassza ki a kívánt dátumot:</label>
                <input v-model="selectedDate" type="date" class="form-control"/>
            </div>
            <button @click="addTestDrive()" type="button" class="btn btn-secondary">Lefoglalás!</button>
        </form>
        <p v-if="message">{{message}}</p>
        <button v-if="message" @click="store.testDriveModal = false,
        selectedDate = null,
        message = ''"
        class="btn btn-secondary">Ok</button>
    </div>
</dialog>

</template>

<style scoped>

    dialog{
        z-index: 100;
        position: fixed;
        top: 0;
        left: 0;
        bottom: 0;
        right: 0;
       width: 40%;
       height: 55%;
       background-color: #B0AAB5;
       border-radius: 5px;
       border: solid 2px black;
    }
    .modalContent{
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100%;
        gap: 1rem;
        position: relative; /* Added for exit button positioning */
    }

    /* Exit button styles */
    .exit-button {
        position: absolute;
        top: 10px;
        left: 10px;
        background-color: #483E52;
        color: white;
        border: none;
        border-radius: 50%;
        width: 35px;
        height: 35px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        font-size: 18px;
        
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .exit-button:hover {
        background-color: #241929;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
    }

    .exit-button:active {
        transform: scale(0.95);
    }

    form{
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    button{
        background-color: #6B676B;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
</style>