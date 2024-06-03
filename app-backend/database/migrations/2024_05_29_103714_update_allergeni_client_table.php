<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class UpdateAllergeniClientTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
            Schema::create('allergeni_client', function (Blueprint $table) {
                $table->id();
                $table->integer('client_id');
                $table->integer('allergeni_id');
    
                $table->foreign('client_id')->references('id')
                    ->on('clients')->onDelete('cascade');
                $table->foreign('allergeni_id')->references('id')
                    ->on('allergeni')->onDelete('cascade');
            

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('allergeni_clienti');
    }
}
