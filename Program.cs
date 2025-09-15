using AlunosApi.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// 1?? Adiciona o DbContext com PostgreSQL
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("DefaultConnection")));

// 2?? Adiciona suporte a controllers, Swagger, etc.
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// 3?? Adiciona CORS: permite acesso do React na porta 3000
builder.Services.AddCors(options =>
{
    options.AddPolicy("ReactPolicy", policy =>
    {
        policy.WithOrigins("http://localhost:3000") // URL do React
              .AllowAnyHeader()
              .AllowAnyMethod();
    });
});

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// 4?? Habilita redirecionamento HTTPS
app.UseHttpsRedirection();

// 5?? Aplica a política de CORS antes do Authorization
app.UseCors("ReactPolicy");

// 6?? Middleware de autorização
app.UseAuthorization();

// 7?? Mapeia os endpoints dos controllers
app.MapControllers();

app.Run();
