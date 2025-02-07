<template>
  <div id="app" class="container">
    <div class="folder-tree">
      <FolderTree
        :activeFolder="activeFolder"
        @folder-selected="handleFolderSelected"
      />
    </div>
    <div class="folder-content">
      <FolderContent
        :selectedFolder="selectedFolder"
        @subfolder-selected="handleSubFolderSelected"
      />
    </div>
  </div>
</template>

<script setup>
import FolderTree from './components/FolderTree.vue';
import FolderContent from './components/FolderContent.vue';
import { ref } from 'vue';

const selectedFolder = ref(null); // Folder yang dipilih di panel kanan
const activeFolder = ref(null); // Folder yang aktif di panel kiri

// Fungsi untuk menangani folder yang dipilih di panel kiri
const handleFolderSelected = (folder) => {
  selectedFolder.value = folder;
  activeFolder.value = folder;
};

// Fungsi untuk menangani subfolder yang dipilih di panel kanan
const handleSubFolderSelected = (subFolder) => {
  selectedFolder.value = subFolder;
  activeFolder.value = subFolder; // Perbarui activeFolder
};
</script>
<style>
/* Pastikan body dan html mengisi seluruh layar */
body, html {
  margin: 0;
  padding: 0;
  height: 100%;
  width: 100%;
}

/* Container utama mengisi seluruh layar */
.container {
  display: flex;
  height: 100vh; /* Mengisi seluruh tinggi layar */
  width: 100vw; /* Mengisi seluruh lebar layar */
  margin: 0;
  padding: 0;
  color: #000000; /* Warna font */

}

.folder-tree {
  flex: 0 0 250px; /* Fixed width untuk panel folder tree */
  background-color: #f1f1f1;
  overflow-y: auto;
  border-right: 2px solid #ccc;
  padding: 10px;
}
.folder-content {
  flex-grow: 1; /* Mengisi sisa ruang yang tersedia */
  background-color: #fff;
  overflow-y: auto;
  padding: 10px;
}
</style>