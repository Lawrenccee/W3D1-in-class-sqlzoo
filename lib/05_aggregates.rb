# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def example_sum
  execute(<<-SQL)
    SELECT
      SUM(population)
    FROM
      countries
  SQL
end

def continents
  # List all the continents - just once each.
  execute(<<-SQL)
    SELECT
      DISTINCT continent
    FROM
      countries
  SQL
end

def africa_gdp
  # Give the total GDP of Africa.
  execute(<<-SQL)
    SELECT
      SUM(gdp) AS total_gdp
    FROM
      countries
    WHERE
      continent ILIKE 'africa'
  SQL
end

def area_count
  # How many countries have an area of more than 1,000,000?
  execute(<<-SQL)
    SELECT
      COUNT(name) AS area_greater_than_1mil
    FROM
      countries
    WHERE
      area > 1000000
  SQL
end

def group_population
  # What is the total population of ('France','Germany','Spain')?
  execute(<<-SQL)
    SELECT
      SUM(population) AS sub_total
    FROM
      countries
    WHERE
      name IN ('France','Germany','Spain')
  SQL
end

def country_counts
  # For each continent show the continent and number of countries.
  execute(<<-SQL)
    SELECT
      continent, COUNT(name) AS countries
    FROM
      countries
    GROUP BY
      continent
  SQL
end

def populous_country_counts
  # For each continent show the continent and number of countries with
  # populations of at least 10 million.
  execute(<<-SQL)
    SELECT
      continent, COUNT(country_count) AS population_at_least_10mil
    FROM (
      SELECT
        *
      FROM
        countries
      WHERE
        population >= 10000000
    ) AS country_count
    GROUP BY
      continent
  SQL
end

def populous_continents
  # List the continents that have a total population of at least 100 million.
  execute(<<-SQL)
    SELECT
      continent
    FROM (
      SELECT
        continent, SUM(population) AS pop
      FROM
        countries
      GROUP BY
        continent
    ) AS large_continents
    WHERE
      large_continents.pop > 100000000
  SQL
end
