<script lang="ts">
    export let instructions: string;

    let dragging: 'horizontal' | 'vertical' | null = null;
    let leftWidth = 300;
    let topHeight = 0;

    

</script>

<div class="flex flex-col h-screen bg-base-300">
    <!-- Top Bar -->
    <div class="flex flex-row justify-between items-center p-3 border-b">
        <!-- Exit Button -->
        <button 
            class="btn btn-square btn-ghost btn-sm"
            aria-label="Close Editor">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
        </button>
        
        <!-- Progress Bar  -->
         <div class="w-1/3">
            <progress class="progress progress-success" value="50" max="100">
            </progress>
        </div>

        <!-- Dummy div for future content  -->
         <div class="w-4 h-4">
         </div>
    </div>
    
    <!-- Main Content Wrapper -->
    <div class="flex-1 overflow-hidden">
        <div class="flex flex-row gap-3 p-3 h-full">
            <!-- Instruction Panel  -->
            <div class="flex flex-col rounded-lg bg-base-200 flex-1 min-h-0 overflow-auto border">
                <div class="p-3 font-semibold border-b bg-base-100">
                    Instructions
                </div>
                <div class="p-3">
                    {@html instructions}
                </div>
            </div>

            <div class="flex-1 min-h-0 flex flex-col gap-3">
                <!-- Code Editor  -->
                <div class="flex flex-col rounded-lg bg-base-200 basis-2/3 flex-grow overflow-auto border">
                    <div class="p-3 font-semibold border-b bg-base-100">
                        Code Editor
                    </div>
                    <div class="p-3">
                        <textarea class="textarea w-full h-40 resize-none"></textarea>
                    </div>
                </div>

                <!-- Output Panel  -->
                <div class="flex flex-col rounded-lg bg-base-200 basis-1/3 flex-grow overflow-auto border">
                    <div class="p-3 font-semibold border-b bg-base-100">
                        Output
                    </div>
                    <div class="p-3">
                        <pre>Something</pre>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>