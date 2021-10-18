Select * 
From [Portfolio Project].dbo.CovidDeaths
Where Continent is not null
Order By 3, 4;

--Select * 
--From CovidVaccinations
--Order By 3, 4

--Select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From [Portfolio Project].dbo.CovidDeaths
Where Continent is not null
Order By 1, 2

--Looking at Total Cases vs Total Deaths

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
From [Portfolio Project].dbo.CovidDeaths
Where location like 'Singapore'
and Continent is not null
Order By 1, 2

--Looking at Total Cases vs Population
--Shows what percentage of population got Covid

Select location, date, Population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
From [Portfolio Project].dbo.CovidDeaths
--Where location like 'Singapore'
Where Continent is not null
Order By 1, 4



--Looking at countries with highest infections rate compared to population

Select location, Population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 AS PercentPopulationInfected
From [Portfolio Project].dbo.CovidDeaths
--Where location like 'Singapore'
Group By location, population
Order By PercentPopulationInfected desc

-- Showing Countries with the Highest Death Counts per Population

Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Portfolio Project].dbo.CovidDeaths
--Where location like 'Singapore'
Where Continent is not null
Group By location
Order By TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT

Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Portfolio Project].dbo.CovidDeaths
--Where location like 'Singapore'
Where Continent is null
Group By location
Order By TotalDeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing continents with the highest death count per population

Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From [Portfolio Project].dbo.CovidDeaths
--Where location like 'Singapore'
Where Continent is not null
Group By location
Order By TotalDeathCount desc


-- GLOBAL NUMBERS

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DeathPercentage
From [Portfolio Project].dbo.CovidDeaths
-- Where location like 'Singapore'
Where Continent is not null
--Group By date
Order By 1, 2


--Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.Location Order by dea.Location, dea.Date)
From [Portfolio Project].dbo.CovidDeaths dea
Join [Portfolio Project].dbo.CovidVaccinations vac
On dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
Order By 2, 3
