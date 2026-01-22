<template>
    <div>
        <h3>Jelenleg keresett autóim:</h3>
        
        <div class="list">
            <ul v-if="wishes.length > 0">
                <li v-for="wish in wishes" :key="wish.id">
                    <span><i class="ri-arrow-right-s-line"></i></span>
                    <table class="table">
                        <thead>
                            <tr>
                                <th><strong>Model/Márka</strong></th>
                                <th><strong>Teljesítmény (cm³)</strong></th>
                                <th><strong>Fogyasztás (l)</strong></th>
                                <th><strong>Ár (Ft)</strong></th>
                                <th><strong>Sebességváltó</strong></th>
                                <th><strong>Üzemanyag</strong></th>
                                <th><strong>Műveletek</strong></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>{{ wish.model || '-' }}</td>
                                <td>{{ wish.performance || '-' }}</td>
                                <td>{{ wish.consumption || '-' }}</td>
                                <td>{{ wish.price ? wish.price.toLocaleString() + ' Ft' : '-' }}</td>
                                <td>{{ wish.transmission || '-' }}</td>
                                <td>{{ wish.fuelType || '-' }}</td>
                                
                                <td style="text-align: center;">
                                    <button @click="$emit('remove-wish', wish.id)" class="delete-btn" title="Szűrő törlése">
                                        <i class="ri-delete-bin-line"></i> Törlés
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </li>
            </ul>

            <div v-else class="empty-state">
                <p>Még nem adtál hozzá kívánságot.</p>
            </div>
        </div>
    </div>
</template>

<script setup>
defineProps({
    wishes: { type: Array, required: true }
});
defineEmits(['remove-wish']);
</script>

<style scoped>
h3{ font-weight: 500; text-align: center; border-bottom: 3px solid #C8BCCF; padding: 10px; padding-bottom: 25px; margin-top: 5px; }
.list{ margin-top: 30px; }
th, td{ padding: 10px; text-align: center; }
li{ display: flex; align-items: center; margin-bottom: 20px; gap: 30px; list-style-type: none; }
table{ border-collapse: collapse; width: 100%; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); border-radius: 8px; overflow: hidden; margin-right: 40px; }

.delete-btn {
    background-color: #ff4d4d;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 5px 10px;
    cursor: pointer;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 5px;
    margin: 0 auto;
}
.delete-btn:hover { background-color: #d63030; }
.empty-state { text-align: center; color: #888; margin-top: 20px; font-style: italic; }
</style>