<template>
    <div>
      <ul>
        <FolderItem
          v-for="folder in folders"
          :key="folder.id"
          :folder="folder"
          :activeFolder="activeFolder"
          @folder-selected="selectFolder"
        />
      </ul>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue';
  import axios from 'axios';
  import FolderItem from './FolderItem.vue';
  
  const emit = defineEmits(['folder-selected']);
  
  const props = defineProps({
    activeFolder: Object, // Folder yang aktif
  });
  
  const folders = ref([]);
  
  // Fetch data folder root (folder tanpa parent_id)
  onMounted(async () => {
    try {
      const response = await axios.get('http://localhost:3000/folders');
      folders.value = response.data;
    } catch (error) {
      console.error("Failed to load folders:", error);
    }
  });
  
  const selectFolder = (folder) => {
    emit('folder-selected', folder);
  };
  </script>
  
  <style scoped>
  ul {
    padding: 0;
    list-style-type: none;
  }
  </style>