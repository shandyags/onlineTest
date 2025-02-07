<template>
    <div class="folder-content">
      <h3>{{ selectedFolder?.name || "Select a folder" }}</h3>
      <ul>
        <li
          v-for="subFolder in subFolders"
          :key="subFolder.id"
          class="sub-folder"
          @click="selectSubFolder(subFolder)"
        >
          <span class="folder-icon">📁</span>
          <span>{{ subFolder.name }}</span>
        </li>
      </ul>
    </div>
  </template>
  
  <script setup>
  import { ref, watch, defineProps, defineEmits } from 'vue';
  import axios from 'axios';
  
  const props = defineProps({
    selectedFolder: Object, // Folder yang dipilih di panel kiri
  });
  
  const emit = defineEmits(['subfolder-selected']); // Event untuk mengirim subfolder yang dipilih
  
  const subFolders = ref([]); // Daftar subfolder
  
  // Fetch subfolder saat folder dipilih
  watch(() => props.selectedFolder, async (newFolder) => {
    if (newFolder) {
      try {
        const response = await axios.get(`http://localhost:3000/folders/${newFolder.id}/subfolders`);
        subFolders.value = response.data;
      } catch (error) {
        console.error("Failed to fetch subfolders:", error);
        subFolders.value = [];
      }
    }
  }, { immediate: true });
  
  // Fungsi untuk menangani klik pada subfolder
  const selectSubFolder = (subFolder) => {
    emit('subfolder-selected', subFolder); // Kirim event ke parent component
  };
  </script>
  
  <style scoped>
  ul {
    padding: 0;
    list-style-type: none;
  }
  
  .sub-folder {
    cursor: pointer; /* Ubah kursor menjadi pointer */
    padding: 5px;
    display: flex;
    align-items: center;
  }
  
  .sub-folder:hover {
    background-color: #f1f1f1; /* Efek hover */
  }
  
  .folder-icon {
    margin-right: 5px;
  }
  </style>