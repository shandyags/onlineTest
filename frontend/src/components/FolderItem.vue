<template>
    <li>
      <!-- Folder Item -->
      <div
        @click="toggle"
        class="folder-item"
        :class="{ 'active-folder': folder.id === activeFolder?.id }"
      >
        <span class="folder-icon">📁</span>
        <span>{{ folder.name }}</span>
      </div>
  
      <!-- Subfolders -->
      <ul v-if="isOpen && subFolders.length">
        <FolderItem
          v-for="subFolder in subFolders"
          :key="subFolder.id"
          :folder="subFolder"
          :activeFolder="activeFolder"
          @folder-selected="$emit('folder-selected', $event)"
        />
      </ul>
    </li>
  </template>
  
  <script setup>
  import { ref, watch } from 'vue';
  import axios from 'axios';
  
  const props = defineProps({
    folder: Object, // Data folder yang diterima
    activeFolder: Object, // Folder yang aktif
  });
  
  const emit = defineEmits(['folder-selected']);
  
  const isOpen = ref(false); // State untuk membuka/menutup folder
  const subFolders = ref([]); // State untuk menyimpan subfolder
  
  // Fetch subfolder saat folder dibuka atau dipaksa terbuka
  const fetchSubFolders = async () => {
    try {
      const response = await axios.get(`http://localhost:3000/folders/${props.folder.id}/subfolders`);
      subFolders.value = response.data;
    } catch (error) {
      console.error("Failed to fetch subfolders:", error);
    }
  };
  
  // Buka folder dan fetch subfolder jika diperlukan
  const toggle = async () => {
    isOpen.value = !isOpen.value; // Toggle state
  
    if (isOpen.value && !subFolders.value.length) {
      await fetchSubFolders();
    }
  
    emit('folder-selected', props.folder); // Emit event saat folder diklik
  };
  
  // Jika activeFolder berubah, buka folder dan fetch subfolder jika diperlukan
  watch(() => props.activeFolder, async (newActiveFolder) => {
    if (newActiveFolder && props.folder.id === newActiveFolder.id) {
      isOpen.value = true; // Buka folder
      await fetchSubFolders(); // Fetch subfolder
    }
  }, { immediate: true });
  </script>
  
  <style scoped>
  .folder-item {
    cursor: pointer;
    padding: 5px;
    display: flex;
    align-items: center;
  }
  
  .folder-item:hover {
    background-color: #e0e0e0;
  }
  
  .folder-item.active-folder {
    background-color: #cce5ff; /* Warna untuk folder aktif */
    font-weight: bold;
  }
  
  .folder-icon {
    margin-right: 5px;
  }
  
  ul {
    padding-left: 20px; /* Indentasi untuk subfolder */
    list-style-type: none;
  }
  </style>