<script>
</script>
<template>
  <body>
    <header>
      <h1>Kapcsolat</h1>
    </header>
    <main>
      <section class="contact-section">
        <h2>Keresse minket bizalommal!</h2>
        <p>
          Kérdése van egyik autónkkal kapcsolatban? Szeretné kipróbálni kiszemeltjét egy próbakörön, vagy saját autóját számíttatná be? Szakértő kollégáink várják hívását vagy személyes látogatását!
        </p>
      </section>

      <section class="contact-section">
        <h2>📍 Telephelyünk címe</h2>
        <p>
          <strong>Második Kör Autókereskedés</strong><br>
          1106 Budapest, Kerepesi út 120/B.<br>
          <em>(Kényelmes parkolás az udvarban, közvetlenül a főút mellett.)</em>
        </p>
        
        <div class="image-placeholder">
           <img src="../assets/elso.jpg" alt="Telephely fotó 1" class="contact-image" />
        </div>
      </section>

      <section class="contact-section">
        <h2>Elérhetőségeink és Nyitvatartás</h2>
        
        <p><strong>📞 Telefonos elérhetőségeink</strong></p>
        <ul>
          <li>Értékesítés és információ: +36 30 123 4567</li>
          <li>Hitelügyintézés és biztosítás: +36 30 987 6543</li>
          <li>Vezetékes vonal: +36 1 234 5678</li>
        </ul>

        <p><strong>📧 E-mail címünk</strong></p>
        <ul>
          <li>Általános információ: info@masodikkor.hu</li>
          <li>Értékesítés: eladas@masodikkor.hu</li>
        </ul>

        <p><strong>🕒 Nyitvatartás</strong></p>
        <ul>
          <li>Hétfő – Péntek: 09:00 – 18:00</li>
          <li>Szombat: 09:00 – 13:00</li>
          <li>Vasárnap: Zárva (Előzetes egyeztetés alapján egyedi időpont lehetséges)</li>
        </ul>

        <div class="image-placeholder">
           <img src="../assets/masodik.jpg" alt="Telephely fotó 2" class="contact-image" />
        </div>
      </section>
    </main>
    <footer>
      <p>&copy; 2025 Második Kör Autókereskedés. Minden jog fenntartva.</p>
    </footer>
  </body>
</template>
<style scoped>
body {
        font-family: "Oswald", sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
      }
      header {
        background-color: #333;
        color: #fff;
        padding: 1rem;
        text-align: center;
      }
      main {
        padding: 2rem;
      }
      .contact-section {
        background-color: #fff;
        padding: 1.5rem;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        margin-bottom: 2rem;
      }
      .contact-section h2 {
        margin-top: 0;
        border-bottom: 2px solid #f4f4f4;
        padding-bottom: 0.5rem;
      }
      .contact-section ul {
        line-height: 1.6;
        padding-left: 20px;
      }
      .contact-image {
        width: 100%;
        max-width: 600px;
        height: 300px;
        background-color: #e0e0e0;
        object-fit: cover;
        margin-top: 15px;
        display: block;
      }
      .image-placeholder {
        text-align: center;
        margin-top: 20px;
      }
      footer {
        background-color: #333;
        color: #fff;
        text-align: center;
        padding: 1rem;
        position: relative;
        bottom: 0;
        width: 100%;
      }
</style>