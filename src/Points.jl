module Points

using LinearAlgebra

export Point, Circle, Square, center, neighbors

struct Point
	x
	y
end

struct Circle
	o::Point
	radius
end

struct Square
	o::Point
	side
end


function Base.:+(fi::Point, se::Point)
	return Point(fi.x + se.x, fi.y + se.y)
end

function Base.:-(fi::Point, se::Point)
	return Point(fi.x - se.x, fi.y - se.y)
end

function Base.:-(p::Point)
	return Point(-p.x,-p.y)
end

function Base.:*(num::Real, p::Point)
	return Point(p.x * num, p.y * num)
end

function Base.:*(p::Point, num::Real)
	return Point(p.x * num, p.y * num)
end

function Base.:/(p::Point, num::Real)
	return Point(p.x / num, p.y / num)
end

function LinearAlgebra.norm(p::Point)
	return sqrt(p.x^2 + p.y^2)
end

function LinearAlgebra.dot(fi::Point, se::Point)
	return (fi.x*se.x + fi.y*se.y)
end

function Base.in(p::Point, area::Circle)
	return (norm(p - area.o) <= area.radius)
end


function Base.in(p::Point, area::Square)
	return (abs(p.x-area.o.x) <= area.side/2 && abs(p.y-area.o.y) <= area.side/2)
end

#закомменченный метод выводил ошибку  тесте 23

#function center(points)
#	sum_x = 0
#	sum_y = 0
#	for i in 1:length(points)
#		sum_x = sum_x + points[i].x
#		sum_y = sum_y + points[i].y
#	end
#	return Point(sum_x/length(points), sum_y/length(points))
#end

center(points) = sum(points)/length(points)

function neighbors(points, origin::Point, k::Int)
	points_vec = Point[]
	for i in 1:length(points)
		push!(points_vec, points[i])
	end
	if length(points_vec) <= k
		return setdiff(points_vec, [origin])
	elseif k <= 0
		return Point[]
	else		
		for i in 1:length(points_vec)
			points_vec[i] = points_vec[i] - origin
		end		
		norms = map(norm, points_vec)
		normperm = sortperm(norms)
		result = points[normperm]
		for i in 1:length(points)
			result[i] = result[i] + origin
		end 
		return setdiff(result, [origin])[1:k]
	end
end

function center(points, area)
	in_points = Point[]
	for i in 1:length(points)
		if (points[i] in area)
			push!(in_points, points[i])
		end
	end
	return center(in_points)
end

end # module
