<script setup>
import { onMounted, ref } from 'vue';
import TestCard from '../components/testCard.vue';
import { useController } from '../stores/UIcontrol';

const store = useController();
const myTestDrives =  ref([]);
const allFavs = ref([])

const getAllFavs = async () => {
      const res = await fetch(`http://localhost:3300/cars/allFavs`)
        const data = await res.json();
        allFavs.value = data;
        console.log(allFavs.value)
    };
const countLikes = (carId) => {
    let count = 0;
    allFavs.value.forEach(fav => {
        if (fav.autoId === carId) {
            count++;
        }
    });
    return count;
};

onMounted(()=>{
   getAllFavs();
})

const getMyTestDrives = async () => {
    try{
    const res = await fetch(`http://localhost:3300/cars/geTest/${store.id}`);
    const data = await res.json();
    myTestDrives.value = data;
    console.log(myTestDrives.value);
    }catch(err){console.error(err)}
}

const removeTestDrive = async(id) => {
    try {
        const res = await fetch(`http://localhost:3300/cars/deleteTest/${id}`, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json'
            }
        });
        if (res.status === 200) {
            console.log('Sikeres törlés a teszt vezetésből');
            getMyTestDrives();
        } else {
            console.error('Hiba történt a törlés során');
        }
    } catch (err) {
        console.error(err);
    }
};


onMounted(()=>{
    getMyTestDrives();
    }
);

</script>

<template>
<div class="testDrivesPage">
<div class="pageTitle">
    <h1>Teszt vezetéseim</h1>
</div>

<div v-if="myTestDrives.length === 0">
    <p class="noTestDrives">Nincsenek teszt vezetéseid.</p>
</div>
<div v-else>
    <ul class="testContainer">
        <li class="testItem"
         v-for="testDrive in myTestDrives" :key="testDrive.id">
            <TestCard class="testCard" 
            :car="testDrive" 
            :likes="countLikes(testDrive.Autok.id)"
            :refresh-drives="getMyTestDrives" />
           <div class="testDate"><span><i class="ri-calendar-check-fill"></i></span> {{ testDrive.datum.substring(0, 10) || 'N/A' }}</div>
           <button @click="removeTestDrive(testDrive.id)" class="btn btn-danger"><span><i class="ri-calendar-close-fill"></i></span>Lemondás</button>
        </li>
    </ul>
</div>
</div>
</template>

<style scoped>
.testDrivesPage{
  background-color: #DDEDE9;
    min-height: 100vh;
    padding-bottom: 3px;

}
.pageTitle{
    position: relative;
    left: 27%;
    text-align: center;
    margin-bottom: 70px;
    border-bottom: solid 4px #C8BCCF;
    width: 40%;
    padding: 30px 20px 15px 20px;
}
.noTestDrives{
    text-align: center;
    font-size: 1.8rem;
    font-weight: 600;
    color: #555555;
    margin-right: 85px;
}
.testContainer{
    display: flex;
    flex-direction: column;
    gap: 20px;
    margin-top: 30px;
    padding: 0;
}
.testItem{
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 7rem;
    margin-bottom: 30px;
    padding-bottom: 50px;
    border-bottom: solid 2px #C8BCCF;
}


.testDate{
    letter-spacing: 4px;
    font-weight: 600;
    font-size: 2.3rem;
    backdrop-filter: blur(10px);
    background: rgba(163, 201, 196, 0.3);
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    padding: 25px 35px;
    color: #2c3e50;
    text-shadow: 0 1px 2px rgba(255, 255, 255, 0.8);
    display: flex;
    align-items: center;
    gap: 15px;
    min-width: 300px;
    justify-content: center;
}

.btn{
    display: flex;
    gap: 15px;
    justify-content: center;
    padding: 30px 0px;
    font-size: 1.5rem;
    width: 370px;
}
.testCard{
    width: 300px;
    height: 340px;
}
</style>