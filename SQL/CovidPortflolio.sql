
SELECT location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths$ 

order by 1,2

--Total cases vs Total deaths (probabilité de déces du covid selon le pays ou tu es)
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as PercentageDeaths
from CovidDeaths$
where location like '%states%'
order by 1,2

--Pourcentage de la population ayant eu le covid par pays
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentageCases
from CovidDeaths$
where location like '%states%'
order by 1,2

--Les pays ayant un taux d'infection elevé comparé à la population
SELECT location, population, Max(total_cases) as "MaxCas", Max((total_cases/population))*100 as PercentageMaxCas
from CovidDeaths$
group by location, population
order by PercentageMaxCas desc

--Montrant les pays avec les taux de mortalité les plus élevés par rapport à la population
SELECT location, Max(cast(total_deaths as int)) as "MaxDeces" --Max((total_deaths/population))*100 as PercentageMaxDeaths
from CovidDeaths$
where continent is not null
group by location
order by MaxDeces desc

--Montrant les pays avec les taux de mortalité les plus élevés par rapport à la population

SELECT location, Max(cast(total_deaths as int)) as "MaxDeces" --Max((total_deaths/population))*100 as PercentageMaxDeaths
from CovidDeaths$
where continent is null
group by location
order by MaxDeces desc

--Vu globe
SELECT SUM(new_cases) as total_cases, SUM((cast(new_deaths as int))) as total_deaths, 
(SUM((cast(new_deaths as int)))/SUM(new_cases))*100 as percentage
FROM CovidDeaths$
where continent is not null
order by 1,2


--Looking at total population vs vaccinations

with PopvsVac(Continent, Location, Date, Population, New_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as int)) over (Partition by dea.location order by dea.location, dea.date)
as RollingPeopleVaccinated
	from CovidDeaths$ dea
    inner join CovidVaccinations$ vac
	on dea.location=vac.location
	and dea.date=vac.date
	where dea.continent is not null

)
Select *, (RollingPeopleVaccinated/Population)*100 as percentagePeopleVaccinated
From PopvsVac
order by 1,2


DROP TABLE if exists

Create TABLE #PercentPopulationVaccinated
(
    Continent varchar(255),
    Location nvarchar(255),
    Date datetime,
    Population numeric(18,2),
    New_vaccinations numeric(18,2),
    RollingPeopleVaccinated numeric(18,2)
);


INSERT INTO #PercentPopulationVaccinated
(
    Continent,
    Location,
    Date,
    Population,
    New_vaccinations,
    RollingPeopleVaccinated
)
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS bigint)) 
        OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
FROM CovidDeaths$ dea
INNER JOIN CovidVaccinations$ vac
    ON dea.location = vac.location
    AND dea.date = vac.date
--WHERE dea.continent IS NOT NULL;

