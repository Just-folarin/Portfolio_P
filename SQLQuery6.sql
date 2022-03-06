
select * from coviddeaths
where continent is not null
order by 3,4

--select * from covidvaccinations
--order by 3,4

-- select data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from coviddeaths
order by 1,2

-- looking at the total cases vs total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from coviddeaths
where location like 'nigeria'
order by 1,2


-- location at total cases vs population
select location, date, total_cases, population, (total_cases/population)*100 as percent populationinfected
from coviddeaths
where location like 'nigeria'
order by 1,2

-- looking at countries with highest infection rate compared to population
select location, population, max(total_cases) as highestinfectioncount,  max((total_cases/population))*100 as percentpopulationinfected
from coviddeaths
--where location like 'nigeria'
group by location, population
order by percentpopulationinfected desc

-- showing countries with the highest death count per population
select location, max(cast(total_deaths as int)) as totaldeathcount 
from coviddeaths
--where location like 'nigeria'
where continent is not null
group by location
order by totaldeathcount desc

-- breaking it down by continent
select continent, max(cast(total_deaths as int)) as totaldeathcount 
from coviddeaths
--where location like 'nigeria'
where continent is not null
group by continent
order by totaldeathcount desc

-- showing the continent with the highest death count

select continent, max(cast(total_deaths as int)) as totaldeathcount 
from coviddeaths
--where location like 'nigeria'
where continent is not null
group by continent
order by totaldeathcount desc

-- GLOBAL NUMBERS
select  date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_death
from coviddeaths
--where location like 'nigeria'
where continent is not null
group by date
order by 1,2


--looking at the total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,sum(cast(new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date)
from  portfolioproject..covidvaccinations vac
JOIN portfolioproject..coviddeaths dea
   on dea.location = vac.location
   and dea.date = vac.date
   where dea.continent is not null
   order by 2,3

