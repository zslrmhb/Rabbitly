<script lang="ts">
    export let value: number;
  </script>
  
  <div class="progress-container">
    <div class="progress-fill" style="width: {Math.min(value * 100, 100)}%"></div>
  </div>
  
  <style>
    .progress-container {
      position: fixed;
      top: 10px;
      left: 50%;
      transform: translateX(-50%);
      width: 60%;
      height: 18px;
      background-color: #f2f2f2;
      border-radius: 999px;
      overflow: hidden;
      z-index: 9999;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }
  
    .progress-fill {
      height: 100%;
      background-color: #22c55e;
      border-radius: 999px;
      transition: width 0.4s ease;
    }
  </style>
  