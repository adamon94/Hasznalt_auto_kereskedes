<template>
    <h3>Jelenleg keresett autóim:</h3>
    <div class="list">
        <ul>

            <li>
                <span><i class="ri-arrow-right-s-line"></i></span>
                <table class="table">
                    <thead>
                        <tr>
                            <th><strong>Típus</strong></th>
                            <th><strong>Teljesítmény</strong></th>
                            <th><strong>Fogyasztás</strong></th>
                            <th><strong>Ár</strong></th>
                            <th><strong>Sebességváltó</strong></th>
                            <th><strong>Üzemanyag</strong></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Terepjáró</td>
                            <td>1600</td>
                            <td>8.5</td>
                            <td>5000000</td>
                            <td>Automata</td>
                            <td>Benzin</td>
                            
                        </tr>
                    </tbody>
                </table>
            </li>

        </ul>

    </div>
</template>

<style scoped>
h3{
    font-weight: 500;
    text-align: center;
    border-bottom: 3px solid #C8BCCF;
    padding: 10px;
    padding-bottom: 25px;
   
    
}

.list{
    margin-top: 30px;
}

th,td{
    padding: 10px;
    text-align: center;
}

li{
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    gap: 30px;
    list-style-type: none;
}

table{
    border-collapse: collapse;
    width: 100%;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
    overflow: hidden;
    margin-right: 40px;
}

</style>